# Planet Four Catalog

It was important for us to put the Planet Four catalog that is described [here](https://planetfour.org/results) under version control.
The new [Intake](https://intake.readthedocs.io/en/latest/) package for data access and distribution is enabling us to achieve this.
Not only will it enable users to simply install and update the catalog using `conda` commands, but in future updates it will include example data plots to make the user faster comfortable what is in the catalag. Stay tuned!

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
['planet4']
```python
# get the data as pandas.DataFrame:
fans = intake.cat.p4cat.fans.read()
fans.shape
```
(158476, 24)
```
# get a description of the catalog
intake.cat.planet4.fans.describe()
```
{'name': 'fans',
 'container': 'dataframe',
 'plugin': ['csv'],
 'description': 'Fan data of the Planet Four catalog',
 'direct_access': 'forbid',
 'user_parameters': [],
 'metadata': {'origin_url': 'https://www.planetfour.org/results'},
 'args': {'urlpath': 'https://www.dropbox.com/s/o70a1x8xzrxfyvg/P4_catalog_v1.1_L1C_cut_0.5_fan.csv.gz?dl=1',
  'csv_kwargs': {'blocksize': None, 'compression': 'gzip'}}}

## Data producers

Build this catalog by doing:

`conda build -c intake p4catalog`

Currently I am simply serving the files via Dropbox links. To be improved.

### Caveats

Things I stumpled upon while producing this:

* Intake is using Dask for reading the remote CSV files and producing the pandas.DataFrames; however, Dask is **not** supporting `zip` as a compression format, so use `gzip` to be fully compatible. In this case, use the `blocksize: null` entry in the `yaml` file to indicate to Dask that you don't make sure of automatic data split-and-scatter.
