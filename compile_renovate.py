# /// script
# dependencies = ['slpp', 'json5', 'pdbpp']
# ///

import json5 as json
import re
from pprint import pprint
from pathlib import Path
from slpp import slpp

renovate_json = Path('renovate.json5')

with renovate_json.open() as fh:
    renovate = json.load(fh)


def get_deps(filename):
    with filename.open() as fh:
        lua = fh.read()

    contents = slpp.decode(lua[len("return") :])

    for dep in contents.values() if isinstance(contents, dict) else contents:
        res = {}

        if isinstance(dep, dict):
            for k, v in dep.items():
                if k == 0:
                    res["name"] = v
                elif k == "branch":
                    res["branch"] = v
        else:
            res["name"] = dep[0]

        res["owner"], res["name"] = res["name"].split("/")

        yield res


deps = [
    dep
    for filename in Path("config/nvim/lua/plugins").glob("*.lua")
    for dep in get_deps(filename)
]
deps.append({"owner": "folke", "name": "lazy.nvim"})
deps.sort(key=lambda x: x["name"])

template = "".join(
    [
        "{{# if (equals depName '%s') }}%s{{/if}}" % (dep["name"], dep["owner"])
        for dep in deps
    ]
)
print(template)

res = f"https://github.com/{template}/{{{{depName}}}}"
print(res)
renovate["customManagers"][0]["depNameTemplate"] = res

renovate["customManagers"][0]["currentValueTemplate"] = "".join(
    [
        "{{# if (equals depName '%s') }}%s{{/if}}"
        % (dep["name"], dep.get("branch", "main"))
        for dep in deps
    ]
)

with renovate_json.open("w") as fh:
    json.dump(renovate, fh, indent=2)
