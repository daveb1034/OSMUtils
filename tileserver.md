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
```

## Install postgresql / postgis

Get the relevant packages from the Ubuntu package manager
```
sudo apt-get install postgresql postgresql-contrib postgis postgresql-9.5-postgis-2.2 pgadmin3
```
Create a database
```
sudo -u postgres -i
createuser username # answer yes for superuser (although this isn't strictly necessary)
createdb -E UTF8 -O osm osm
exit
```
Create a Ubuntu username called osm and set a password
```
sudo useradd -m osm
sudo passwd osm
```
Setup PostGIS and hstore on the PostgreSQL database
```
sudo -u postgres psql
\c osm
CREATE EXTENSION postgis;
CREATE EXTENSION hstore;
ALTER TABLE geometry_columns OWNER TO osm;
ALTER TABLE spatial_ref_sys OWNER TO osm;
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
cd OSMUtils
```

## Import Data

This section details the steps needed to obtain and import the required data.

### Import External Sources
This process only needs to be run the once and will import files external to OpenStreetMap.

Obtain the Natural Earth data as sqlite database. Then run the clean-natural-earth script

#### TODO the clean script needs to have a parameter set and be included in the repo, or the preporcessed sqlite needs to be included.
```

cd ~/src/OSMUtils/src
wget http://naciscdn.org/naturalearth/packages/natural_earth_vector.sqlite.zip
unzip natural_earth_vector.sqlite.zip
./clean-natural-earth.sh
```
