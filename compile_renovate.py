# /// script
# dependencies = ['slpp', 'json5', 'jsonata-python', 'pdbpp']
# ///

import jsonata
import json5
from pathlib import Path
from slpp import slpp

renovate_json = Path("renovate.json5")


def unwrap_dict(dep: dict):
    res = {}
    for k, v in dep.items():
        if k == 0:
            res["name"] = v
        elif k == "branch":
            res["branch"] = v
    return res


def get_deps(filename):
    with filename.open() as fh:
        lua = fh.read()

    contents = slpp.decode(lua[len("return") :])

    for dep in contents.values() if isinstance(contents, dict) else contents:
        res = {}

        single_dep = False
        if isinstance(dep, dict):
            res = unwrap_dict(dep)
        elif isinstance(dep, list):
            res["name"] = dep[0]
        else:
            res = unwrap_dict(contents)
            single_dep = True

        res["owner"], res["name"] = res["name"].split("/")

        yield res

        if single_dep:
            break


def get_all_deps():
    deps = [
        dep
        for filename in Path("config/nvim/lua/plugins").glob("*.lua")
        for dep in get_deps(filename)
    ]
    deps.append({"owner": "folke", "name": "lazy.nvim"})
    deps.sort(key=lambda x: x["name"])
    return deps


def main():
    template = "".join(
        [
            "{{# if (equals depName '%s') }}%s{{/if}}" % (dep["name"], dep["owner"])
            for dep in get_all_deps()
        ]
    )

    res = f"https://github.com/{template}/{{{{depName}}}}"

    with renovate_json.open() as fh:
        renovate = json5.load(fh)

    custom = renovate["customManagers"][0]
    if custom["customType"] == "jsonata":
        expr = jsonata.Jsonata(custom["matchStrings"][0])
        with open("config/nvim/lazy-lock.json") as fh:
            data = json5.load(fh)
        expr.evaluate(data)

    custom["depNameTemplate"] = res

    with renovate_json.open("w") as fh:
        json5.dump(renovate, fh, indent=2, quote_style=json5.QuoteStyle.PREFER_SINGLE)


if __name__ == "__main__":
    main()
