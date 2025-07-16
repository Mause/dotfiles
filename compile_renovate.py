import json
import re
from pprint import pprint

with open('renovate.json') as fh:
    renovate = json.load(fh)

with open('config/nvim/lua/plugins/treesitter.lua') as fh:
    lua = fh.read()

deps = re.findall(r''''([^']+)'|"([^"]+)"''', lua)
deps = [(a or b) for a, b, in deps]
deps = [a.split('/') for a in deps if '/' in a]
pprint(deps)

template = ''.join([("{{# if (equals depName '%s') }}%s{{/if}}" % (depname, owner)) for owner, depname in deps])
print(template)

res = f'https://github.com/{template}/{{{{depName}}}}'
print(res)
renovate['customManagers'][0]['depNameTemplate'] = res

with open('renovate.json', 'w') as fh:
    json.dump(renovate, fh, indent=2)

