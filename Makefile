# Configurable parts
SQL_MODULE := postgis
EXTRA_FILES := LICENSE LICENSE-postgis.txt NOTICE

CUSTOM_SQL_BUILD := 1

### Boilerplate
PYTHON := python3
EDB := $(PYTHON) -m edb.tools $(EDBFLAGS)
MKS := $(shell $(EDB) config --make-include)
include $(MKS)
### End Boilerplate

$(SQL_STAMP): MANIFEST.toml postgis/NEWS Makefile
	cd postgis && sh autogen.sh
	cd postgis && ./configure  "--with-pgconfig=$(PG_CONFIG)" --without-raster
	$(MAKE) -C postgis
	$(MAKE) -C postgis comments
	$(MAKE) -C postgis DESTDIR=$(PWD)/build/out PG_CONFIG=$(PG_DIR)/bin/pg_config install
	touch $(SQL_STAMP)
