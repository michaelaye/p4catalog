# Planet Four Catalog

This is a repository with the files used to create a versioned and conda-installable catalog of the results from [Aye et al, 2019](https://arxiv.org/abs/1803.10341).

See [Data users section](#data-users) below if you just want to install the catalog and use it.

## Description

It was important for us to put the Planet Four catalog that is described [here](https://planetfour.org/results) under version control.
The new [Intake](https://intake.readthedocs.io/en/latest/) package for data access and distribution is enabling us to achieve this.
Not only will it enable users to simply install and update the catalog using `conda` commands, but, provided in future updates, example data plots created from the installed catalog simply by executing `plot()` will make the user faster comfortable with what is offered by the catalag. Stay tuned! (Click "Watch" above to be notified about any changes.)

This repository contains everything to built the catalog, so it mostly serves as an example to other data producers how to share their data using `conda`.

## Data users

Install the catalog by using my conda channel:

```
conda install -c michaelaye planetfour-catalog
```
and then access it inside Python like so:

```python
import intake
# list what catalogs intake has available:
print(list(intake.cat)
```
```
['planet4']
```
```python
# get the data as pandas.DataFrame:
fans = intake.cat.p4cat.fans.read()
fans.shape
```
```
(158476, 24)
```
```
# get a description of the catalog
intake.cat.planet4.fans.describe()
```
```bash
{'name': 'fans',
 'container': 'dataframe',
 'plugin': ['csv'],
 'description': 'Fan data of the Planet Four catalog',
 'direct_access': 'forbid',
 'user_parameters': [],
 'metadata': {'origin_url': 'https://www.planetfour.org/results'},
 'args': {'urlpath': 'https://www.dropbox.com/s/o70a1x8xzrxfyvg/P4_catalog_v1.1_L1C_cut_0.5_fan.csv.gz?dl=1',
  'csv_kwargs': {'blocksize': None, 'compression': 'gzip'}}}
```

## Data producers

Build this catalog by doing:

`conda build -c intake p4catalog`

Currently I am simply serving the files via Dropbox links. To be improved.

### Caveats

Things I stumpled upon while producing this:

* Intake is using Dask for reading the remote CSV files and producing the pandas.DataFrames; however, Dask is **not** supporting `zip` as a compression format, so use `gzip` to be fully compatible. In this case, use the `blocksize: null` entry in the `yaml` file to indicate to Dask that you don't make sure of automatic data split-and-scatter.
* Think about how you want the user to access the data. For example, maybe don't repeat the word `cat` (for catalog) as `intake` already has `cat` in its data access path, so it's superfluous.
* If you want to distribute more than one file, but want to provide them under one identifying namespace (e.g. here: `planet4`), you need to **both** nest the catalog files **and** reflect that structure in the shell script that copies the catalog files around inside the `$CONDA_PREFIX/share/intake` folder. Just follow this example and you should see how it works.

Let me (and the Intake project) know any troubles you face.
