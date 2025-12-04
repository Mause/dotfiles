# /// script
# dependencies = [
#   'slpp',
#   'json5',
#   'jsonata-python',
#   'pdbpp',
#   'pybars3',
#   'rich',
#   'more_itertools',
# ]
# ///
import re
import sys
from fnmatch import translate
from pathlib import Path
from subprocess import check_output
from unittest import TestCase
from unittest import main as unittest_main

import json5
import jsonata
from more_itertools import unique
from pybars import Compiler
from rich import traceback
from slpp import slpp

traceback.install(show_locals=True)

renovate_json = Path("renovate.json5")

# DEBUG: Dependency https://github.com/Saghen/blink.cmp has unsupported/unversioned value main (versioning=git)


def unwrap_dict(dep: dict):
    res = {}
    for k, v in dep.items():
        if k == 0:
            res["name"] = v
        elif k in {"branch", "version"}:
            res[k] = v
        elif k == "dependencies":
            res["dependencies"] = [
                add_owner(unwrap_dict(d) if isinstance(d, dict) else {"name": d})
                for d in v
            ]

    return add_owner(res)


def add_owner(dep: dict):
    if "owner" not in dep:
        dep["owner"], dep["name"] = dep["name"].split("/")
    return dep


def get_deps(filename):
    print("loading", filename)
    with filename.open() as fh:
        lua = fh.read()

    for idx, line in enumerate(lua.splitlines()):
        if line.startswith("return "):
            lua = "\n".join(lua.splitlines()[idx:])
            break

    contents = slpp.decode(lua[len("return") :])

    assert isinstance(contents, (list, dict))

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

        res = add_owner(res)
        if "dependencies" in res:
            yield from res["dependencies"]

        yield res

        if single_dep:
            break


checkout = Path("~/.local/share/nvim/lazy").expanduser()


def get_all_deps():
    assert checkout.exists(), checkout
    deps = [
        dep
        for filename in list(Path("config/nvim/lua/plugins").glob("*.lua"))
        + list(checkout.glob("*/lazy.lua"))
        for dep in get_deps(filename)
    ]
    deps.append({"owner": "folke", "name": "lazy.nvim"})
    return list(unique(deps, key=lambda x: x["name"]))


class Encoder(json5.lib.JSON5Encoder):
    def is_reserved_word(self, word):
        return False if word == "extends" else super().is_reserved_word(word)


def main():
    if not ("CI" in os.environ or "--force" in sys.argv):
        print("Not running locally")
        return
    MARKER = "<<<MARKER>>>"

    deps = get_all_deps()
    template = MARKER.join(
        [
            "{{# if (equals depName '%s') }}%s{{/if}}" % (dep["name"], dep["owner"])
            for dep in deps
        ]
    )

    with Path("config/nvim/lazy-lock.json").open() as fh:
        lazy_lock = json5.load(fh)

    for dep in deps:
        if version := dep.get("version"):
            entry = lazy_lock[dep["name"]]

            tag = (
                check_output(
                    ["git", "tag", "--points-at", entry["commit"]],
                    text=True,
                    cwd=checkout / dep["name"],
                )
                .strip()
                .strip("v")
            )
            assert tag, f"no tag for {dep['name']} at {entry['commit']}"
            translated = translate(version.strip("^"))
            if version.startswith("^"):
                translated = "^" + translated[:-2]
            assert re.match(translated, tag), (
                f"{version} != {tag} for {dep['name']} at {entry['commit']}"
            )

    res = f"https://github.com/{template}/{{{{depName}}}}"

    with renovate_json.open() as fh:
        renovate = json5.load(fh)

    custom = renovate["customManagers"][0]
    custom["depNameTemplate"] = res

    res = json5.dumps(
        renovate,
        indent=2,
        quote_style=json5.QuoteStyle.PREFER_SINGLE,
        cls=Encoder,
    )
    res = "\\\n".join(res.split(MARKER))

    with renovate_json.open("w") as fh:
        fh.write(res + "\n")


class Tester(TestCase):
    def test_compile(self):
        with renovate_json.open() as fh:
            renovate = json5.load(fh)

        custom = renovate["customManagers"][0]

        res = custom["depNameTemplate"]
        compiler = Compiler()
        template = compiler.compile(res)
        helpers = {
            "equals": lambda this, a, b: a == b,
            "containsString": lambda this, string, substring: substring in string,
        }
        output = template({"depName": "nvim-web-devicons"}, helpers=helpers)
        self.assertEqual(output.count("//"), 1)

        if custom["customType"] == "jsonata":
            expr = jsonata.Jsonata(custom["matchStrings"][0])
            with open("config/nvim/lazy-lock.json") as fh:
                data = json5.load(fh)
            expr.evaluate(data)

        datasourceTemplate = compiler.compile(custom["datasourceTemplate"])
        self.assertEqual(
            datasourceTemplate({"depName": "nvim-web-devicons"}, helpers=helpers),
            "git-refs",
        )
        self.assertEqual(
            datasourceTemplate({"depName": "blink.indent"}, helpers=helpers),
            "github-tags",
        )


if __name__ == "__main__":
    main()
    unittest_main(argv=[sys.argv[0]])
