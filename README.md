# communes-algerie-shp
Créer un shape des communes d'Algérie à partir des données d'OpenStreetMap

## Fichiers : 
* ShapeFile : https://github.com/eric-pommereau/communes-algerie-shp/raw/master/dist/communes_algerie_2016-10.zip
* GeoJson : https://github.com/eric-pommereau/communes-algerie-shp/raw/master/dist/communes_algerie_simplif.geojson

![Screenshot](/img/scr-communes-algerie-alger.jpg)
![Screenshot](/img/scr-communes-algerie-global.jpg)

## Récupération des données OSM
```shell
cd datas
wget http://download.geofabrik.de/africa/algeria-latest.osm.pbf
```

## Chargement dans postgreSQL
Préparer la BDD et ajouter postGIS
```shell
psql -c "drop database osm;"
psql -c "create database osm"
psql -d osm -c "create extension postgis;"
```

Charger (de données OSM vers PG) avec ogr2ogr en pointant le fichier osmconf.ini
```shell
ogr2ogr -f PostgreSQL PG:dbname=osm datas/algeria-latest.osm.pbf -lco OVERWRITE=yes -lco SPATIAL_INDEX=YES --config OSM_CONFIG_FILE ./osmconf.ini
psql -d osm -c "vacuum"
```

## Extraction vers shapefile

Export de PG vers shape des donées (admin_level=7 -> les communes).
```shell
ogr2ogr -f "ESRI Shapefile" datas/communes_algerie.shp PG:"dbname=osm" -sql "select osm_id, name, wkb_geometry as geom from multipolygons where admin_level = '7'"psql -d osm -c "vacuum"
```

## Création du geojson simplifié
Import manuel dans mapshaper http://mapshaper.org/ puis sauvegarde en geojson.

