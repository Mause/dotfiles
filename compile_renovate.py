# /// script
# dependencies = ['slpp', 'pdbpp']
# ///

import json
import re
from pprint import pprint
from pathlib import Path
from slpp import slpp

with open("renovate.json") as fh:
    renovate = json.load(fh)


def get_deps(filename):
    with filename.open() as fh:
        lua = fh.read()

    contents = slpp.decode(lua[len('return'):])

    for dep in (contents.values() if isinstance(contents, dict) else contents):
        res = {}

        if isinstance(dep, dict):
            for k, v in dep.items():
                if k == 0:
                    res['name'] = v
                elif k == 'branch':
                    res['branch'] = v
        else:
            res['name'] = dep[0]

        yield res



deps = [
    dep
    for filename in Path("config/nvim/lua/plugins").glob("*.lua")
    for dep in get_deps(filename)
]
deps.append({'name': "folke/lazy.nvim"})

template = "".join(
    [
        "{{# if (equals depName '%s') }}%s{{/if}}" % tuple(dep['name'].split('/'))
        for dep in deps
    ]
)
print(template)

res = f"https://github.com/{template}/{{{{depName}}}}"
print(res)
renovate["customManagers"][0]["depNameTemplate"] = res

with open("renovate.json", "w") as fh:
    json.dump(renovate, fh, indent=2)
