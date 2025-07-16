import json
import re
from pprint import pprint
from pathlib import Path

with open("renovate.json") as fh:
    renovate = json.load(fh)


def get_deps(filename):
    with filename.open() as fh:
        lua = fh.read()

    deps = re.findall(r''''([^']+)'|"([^"]+)"''', lua)
    deps = [(a or b) for a, b in deps]
    deps = [a.split("/") for a in deps if "/" in a and ' ' not in a]
    pprint(deps)
    return deps


deps = [
    dep
    for filename in Path("config/nvim/lua/plugins").glob("*.lua")
    for dep in get_deps(filename)
]
deps.append(("folke", "lazy.nvim.git"))

template = "".join(
    [
        ("{{# if (equals depName '%s') }}%s{{/if}}" % (depname, owner))
        for owner, depname in deps
    ]
)
print(template)

res = f"https://github.com/{template}/{{{{depName}}}}"
print(res)
renovate["customManagers"][0]["depNameTemplate"] = res

with open("renovate.json", "w") as fh:
    json.dump(renovate, fh, indent=2)
