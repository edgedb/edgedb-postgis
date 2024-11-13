# edgedb-postgis

Currently ``make`` and the ``gen_ext_postgis.py`` script should be run
from inside an edgedb development venv.

To build, install, and test into a dev env:
- ``make``
- ``make zip``
- ``edb load-ext postgis--3.4.3.zip``
- ``edb test tests/test_edgeql_postgis.py``
