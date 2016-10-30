/Library/Frameworks/GDAL.framework/Versions/1.11/Programs/ogr2ogr -f PostgreSQL PG:dbname=osm datas/algeria-latest.osm.pbf -lco OVERWRITE=yes -lco SPATIAL_INDEX=YES --config OSM_CONFIG_FILE ./osmconf.ini
psql -d osm -c "vacuum"
