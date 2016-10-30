psql -c "drop database osm;"
psql -c "create database osm"
psql -d osm -c "create extension postgis;"
