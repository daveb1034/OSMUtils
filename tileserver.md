# Configuring an OpenStreetMap tile server (Ubuntu 16.04)

The process described here provides a means of creating a standalone tile server that is capable of creating
Raster and Vector tiles from OpenStreetMap data.

It is inspired and based upon the information contained at:

* [Manually building a tile server from switch2osm](https://switch2osm.org/serving-tiles/manually-building-a-tile-server-14-04/)
* [OSM 2 Vector tiles](http://osm2vectortiles.org/)

This process utilises [imposm3](https://github.com/omniscale/imposm3) to import data into a postgis database.
The import is significantly faster than using [osm2pgsql](https://github.com/openstreetmap/osm2pgsql).

## Installing prerequisites

```
sudo apt-get install libboost-all-dev subversion git-core tar unzip wget bzip2 build-essential autoconf libtool libxml2-dev libgeos-dev libgeos++-dev 
libpq-dev libbz2-dev libproj-dev munin-node munin libprotobuf-c0-dev protobuf-c-compiler libfreetype6-dev libpng12-dev libtiff5-dev libicu-dev 
libgdal-dev libcairo-dev libcairomm-1.0-dev apache2 apache2-dev libagg-dev liblua5.2-dev ttf-unifont lua5.1 liblua5.1-dev libgeotiff-epsg node-carto sqlite3
gdal-bin osmctools
```

## Install postgresql / postgis

Get the relevant packages from the Ubuntu package manager
```
sudo apt-get install postgresql postgresql-contrib postgis postgresql-9.5-postgis-2.2 pgadmin3
```
Create a database and create a user called osm
```
sudo -u postgres -i
createuser osm
createdb -E UTF8 -O osm osm
exit
```
Create a Ubuntu username called osm and set a password
```
sudo useradd -m osm
sudo passwd osm
```
Setup PostGIS and hstore on the PostgreSQL database and set the osm user password to osm.
```
sudo -u postgres psql
\c osm
CREATE EXTENSION postgis;
CREATE EXTENSION hstore;
ALTER TABLE geometry_columns OWNER TO osm;
ALTER TABLE spatial_ref_sys OWNER TO osm;
ALTER USER osm WITH PASSWORD 'osm';
\q
```

## Get the mapbox vector tiles utility functions and install
```
mkdir ~/src
cd ~/src
git clone https://github.com/mapbox/postgis-vt-util.git
cd postgid-vt-util
sudo -u postgres psql
\c osm
\i postgis-vt-util.sql
\q
```

## Install Go and Imposm3
Install Go using
```
sudo apt-get install golang-go
```
Obtain the latest Imposm3 [binary](https://imposm.org/static/rel/).
```
mkdir ~/bin
```
Extract the archive to the `~/bin` and add it to your path.
```
export PATH=$PATH:$HOME/bin
```

## Clone OSMUtils repo
```
cd ~/src
git clone https://github.com/daveb1034/OSMUtils.git
cd OSMUtils/src
```

## Import External Data

Scripts and data used here have been modified from the [osm2vectortiles process](https://github.com/osm2vectortiles/osm2vectortiles/tree/master/src/import-external).


This section details the steps needed to obtain and import the required data.

This process only needs to be run the once and will import files external to OpenStreetMap.

The import script downloads natural earth data and water polygons from openstreetmap.
The natural earth data is cleaned and then imported.

All data is loaded into the public schema of the postgis database in EPSG:3857 by default.
This will potentially be altered in future to use 4326 and possibly 3395.

```
cd import-external
./import.sh
```

## Import OSM Data

This process uses a modified version of the osm2vectortiles import osm.
The ref to pbf_timestamp is removed from the osm2vectortiles process and requires
modifcation of the reference to timestamp field in all the tables.

This is a custom implementation of imposm3 data by osm2vectortiles and is used to render 
updated tiles using diff.
We will do something different.