# p4data
Repository for the Conda build to create a planet four data catalog for Conda install

These are the files required to create an [intake](https://intake.readthedocs.io/en/latest/) catalog.

Build this by doing:

`conda build -c intake p4data`

The data files are reachable via, e.g. for the fan catalog:

```python
import intake

df = intake.cat.p4data.fan.read()
```
