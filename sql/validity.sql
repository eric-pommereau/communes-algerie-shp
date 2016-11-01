-- Vérifier la validité des polygons
select osm_id, name, ST_IsValidDetail(wkb_geometry) as unval_reason from multipolygons 
where admin_level = '7' and ST_IsValid(wkb_geometry) = false;

