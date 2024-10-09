# Configurable parts
SQL_MODULE := postgis
EXTRA_FILES := LICENSE LICENSE-postgis.txt NOTICE

CUSTOM_SQL_BUILD := 1

### Boilerplate
# PYTHON := python3
# EDB := $(PYTHON) -m edb.tools $(EDBFLAGS)
# MKS := $(shell $(EDB) config --make-include)
MKS := exts.mk
include $(MKS)
### End Boilerplate

$(SQL_BUILD_STAMP): MANIFEST.toml postgis/NEWS Makefile
	cd postgis && sh autogen.sh
	cd postgis && ./configure  "--with-pgconfig=$(PG_CONFIG)" --without-raster
	env PG_CONFIG=$(PG_CONFIG) $(MAKE) -C postgis
	env PG_CONFIG=$(PG_CONFIG) $(MAKE) -C postgis comments
	env PG_CONFIG=$(PG_CONFIG) $(MAKE) -C postgis DESTDIR=$(PWD)/build/out install
	touch $(SQL_BUILD_STAMP)
