CREATE OR REPLACE FUNCTION barrier_line_class(type VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
    RETURN CASE
            WHEN type IN ('gate','entrance','spikes','bollard','lift_gate','kissing_gate','stile') THEN 'gate'
            WHEN type IN ('city_wall','fence','retaining_wall','wall','wire_fence','True','embankment','cable_barrier','jersey_barrier') THEN 'fence'
            WHEN type IN ('cliff','earth_bank') THEN 'cliff'
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
    
CREATE OR REPLACE FUNCTION landuse_overlay_class(type VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
    RETURN CASE
            WHEN type IN ('national_park','nature_reserve','protected_area') THEN 'national_park'
            WHEN type IN ('mud','tidalflat') THEN 'wetland_noveg'
            WHEN type IN ('wetland','marsh','swamp','bog') THEN 'wetland'
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
    
CREATE OR REPLACE FUNCTION landuse_class(type VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
    RETURN CASE
            WHEN type IN ('industrial') THEN 'industrial'
            WHEN type IN ('scrub') THEN 'scrub'
            WHEN type IN ('greenfield') THEN 'greenfield'
            WHEN type IN ('park','dog_park','common','garden','golf_course','playground','recreation_ground','village_green','zoo','sports_centre','camp_site') THEN 'park'
            WHEN type IN ('rock','bare_rock','scree','quarry') THEN 'rock'
            WHEN type IN ('commercial') THEN 'commercial'
            WHEN type IN ('school','college','university') THEN 'school'
            WHEN type IN ('athletics','chess','pitch','track') THEN 'pitch'
            WHEN type IN ('orchard','farm','farmland','farmyard','allotments','vineyard','plant_nursery') THEN 'agriculture'
            WHEN type IN ('winter_sports') THEN 'winter_sports'
            WHEN type IN ('retail') THEN 'retail'
            WHEN type IN ('glacier') THEN 'glacier'
            WHEN type IN ('residential') THEN 'residential'
            WHEN type IN ('hospital') THEN 'hospital'
            WHEN type IN ('cemetery','christian','jewish') THEN 'cemetery'
            WHEN type IN ('aboriginal_lands') THEN 'aboriginal_lands'
            WHEN type IN ('landfill') THEN 'landfill'
            WHEN type IN ('sand','beach') THEN 'sand'
            WHEN type IN ('wood','forest') THEN 'wood'
            WHEN type IN ('salt_pond') THEN 'salt_pond'
            WHEN type IN ('military') THEN 'military'
            WHEN type IN ('railway') THEN 'railway'
            WHEN type IN ('grass','grassland','meadow','heath','fell') THEN 'grass'
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
    
CREATE OR REPLACE FUNCTION road_type_class(type VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
    RETURN CASE
            WHEN type IN ('hole') THEN 'golf'
            WHEN type IN ('track') THEN 'track'
            WHEN type IN ('primary') THEN 'primary'
            WHEN type IN ('motorway') THEN 'motorway'
            WHEN type IN ('pedestrian') THEN 'pedestrian'
            WHEN type IN ('unclassified','residential','road','living_street','raceway') THEN 'street'
            WHEN type IN ('trunk_link','primary_link','secondary_link','tertiary_link') THEN 'link'
            WHEN type IN ('trunk') THEN 'trunk'
            WHEN type IN ('steps','corridor','crossing','piste','mtb','hiking','cycleway','footway','path','bridleway') THEN 'path'
            WHEN type IN ('tertiary') THEN 'tertiary'
            WHEN type IN ('secondary') THEN 'secondary'
            WHEN type IN ('service') THEN 'service'
            WHEN type IN ('cable_car','gondola','mixed_lift','chair_lift','drag_lift','t-bar','j-bar','platter','rope_tow','zip_line','magic_carpet','canopy') THEN 'aerialway'
            WHEN type IN ('motorway_link') THEN 'motorway_link'
            WHEN type IN ('construction') THEN 'construction'
            WHEN type IN ('rail','light_rail','subway') THEN 'major_rail'
            WHEN type IN ('ferry') THEN 'ferry'
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
    
CREATE OR REPLACE FUNCTION rail_station_class(type VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
    RETURN CASE
            WHEN type IN ('light_rail','halt','tram_stop') THEN 'rail-light'
            WHEN type IN ('stop','subway') THEN 'rail-metro'
            WHEN type IN ('station') THEN 'rail'
            WHEN type IN ('subway_entrance') THEN 'entrance'
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
    
CREATE OR REPLACE FUNCTION maki_label_class(type VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
    RETURN CASE
            WHEN type IN ('accessories','antiques','art','beauty','bed','boutique','camera','carpet','charity','chemist','chocolate','coffee','computer','confectionery','convenience','copyshop','cosmetics','garden_centre','doityourself','erotic','electronics','fabric','florist','furniture','video_games','video','general','gift','hardware','hearing_aids','hifi','ice_cream','interior_decoration','jewelry','kiosk','lamps','mall','massage','motorcycle','mobile_phone','newsagent','optician','outdoor','perfumery','perfume','pet','photo','second_hand','shoes','sports','stationery','tailor','tattoo','ticket','tobacco','toys','travel_agency','watches','weapons','wholesale') THEN 'shop'
            WHEN type IN ('toilets') THEN 'toilet'
            WHEN type IN ('bicycle') THEN 'bicycle'
            WHEN type IN ('cinema') THEN 'cinema'
            WHEN type IN ('helipad') THEN 'heliport'
            WHEN type IN ('camp_site','caravan_site') THEN 'campsite'
            WHEN type IN ('dog_park') THEN 'dog-park'
            WHEN type IN ('cricket') THEN 'cricket'
            WHEN type IN ('books','library') THEN 'library'
            WHEN type IN ('embassy') THEN 'embassy'
            WHEN type IN ('university','college') THEN 'college'
            WHEN type IN ('hotel','motel','bed_and_breakfast','guest_house','hostel','chalet','alpine_hut','camp_site') THEN 'lodging'
            WHEN type IN ('chocolate','confectionery') THEN 'ice-cream'
            WHEN type IN ('cafe') THEN 'cafe'
            WHEN type IN ('golf','golf_course','miniature_golf') THEN 'golf'
            WHEN type IN ('bicycle_rental') THEN 'bicycle-share'
            WHEN type IN ('alcohol','beverages','wine') THEN 'alcohol-shop'
            WHEN type IN ('police') THEN 'police'
            WHEN type IN ('butcher') THEN 'slaughterhouse'
            WHEN type IN ('bag','clothes') THEN 'clothing-store'
            WHEN type IN ('veterinary') THEN 'veterinary'
            WHEN type IN ('grave_yard','cemetery') THEN 'cemetery'
            WHEN type IN ('theme_park') THEN 'amusement-park'
            WHEN type IN ('pharmacy') THEN 'pharmacy'
            WHEN type IN ('station') THEN 'airfield'
            WHEN type IN ('attraction','viewpoint') THEN 'attraction'
            WHEN type IN ('biergarten','pub') THEN 'beer'
            WHEN type IN ('music','musical_instrument') THEN 'music'
            WHEN type IN ('playground') THEN 'playground'
            WHEN type IN ('american_football','stadium','soccer','pitch') THEN 'stadium'
            WHEN type IN ('prison') THEN 'prison'
            WHEN type IN ('fuel') THEN 'fuel'
            WHEN type IN ('accessories','antiques','art','artwork','gallery','arts_centre') THEN 'art-gallery'
            WHEN type IN ('townhall','public_building','courthouse','community_centre') THEN 'town-hall'
            WHEN type IN ('subway_entrance') THEN 'entrance'
            WHEN type IN ('laundry','dry_cleaning') THEN 'laundry'
            WHEN type IN ('garden') THEN 'garden'
            WHEN type IN ('fast_food','food_court') THEN 'fast-food'
            WHEN type IN ('information') THEN 'information'
            WHEN type IN ('bus_stop','bus_station') THEN 'bus'
            WHEN type IN ('park','bbq') THEN 'park'
            WHEN type IN ('supermarket','deli','delicatessen','department_store','greengrocer','marketplace') THEN 'grocery'
            WHEN type IN ('dentist') THEN 'dentist'
            WHEN type IN ('fire_station') THEN 'fire-station'
            WHEN type IN ('bar','nightclub') THEN 'bar'
            WHEN type IN ('post_box','post_office') THEN 'post'
            WHEN type IN ('bank') THEN 'bank'
            WHEN type IN ('school','kindergarten') THEN 'school'
            WHEN type IN ('theater') THEN 'theater'
            WHEN type IN ('zoo') THEN 'zoo'
            WHEN type IN ('restaurant') THEN 'restaurant'
            WHEN type IN ('marina','dock') THEN 'harbor'
            WHEN type IN ('car','car_repair','taxi') THEN 'car'
            WHEN type IN ('doctor') THEN 'doctor'
            WHEN type IN ('bakery') THEN 'bakery'
            WHEN type IN ('place_of_worship') THEN 'place-of-worship'
            WHEN type IN ('picnic-site') THEN 'picnic-site'
            WHEN type IN ('monument') THEN 'monument'
            WHEN type IN ('ferry_terminal') THEN 'ferry'
            WHEN type IN ('hospital','nursing_home') THEN 'hospital'
            WHEN type IN ('museum') THEN 'museum'
            WHEN type IN ('swimming_area','swimming') THEN 'swimming'
    END;
END;
$$ LANGUAGE plpgsql IMMUTABLE;
    
CREATE OR REPLACE FUNCTION changed_tiles(ts timestamp)
RETURNS TABLE (x INTEGER, y INTEGER, z INTEGER) AS $$
BEGIN
    RETURN QUERY (
                SELECT * FROM changed_tiles_table('osm_housenumber_point', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_building_polygon', ts, 2, 13, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_poi_polygon', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_water_linestring', ts, 8, 8, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_rail_station_point', ts, 64, 12, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_water_polygon', ts, 64, 5, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_aero_linestring', ts, 4, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_housenumber_polygon', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_aero_polygon', ts, 4, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_airport_point', ts, 64, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_poi_point', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_barrier_polygon', ts, 4, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_place_point', ts, 128, 3, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_admin_linestring', ts, 4, 2, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_airport_polygon', ts, 64, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_barrier_linestring', ts, 4, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_road_geometry', ts, 8, 5, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_landuse_polygon', ts, 8, 5, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_mountain_peak_point', ts, 64, 12, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_motorway_junction_point', ts, 8, 12, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_housenumber_point_delete', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_building_polygon_delete', ts, 2, 13, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_poi_polygon_delete', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_water_linestring_delete', ts, 8, 8, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_rail_station_point_delete', ts, 64, 12, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_water_polygon_delete', ts, 64, 5, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_aero_linestring_delete', ts, 4, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_housenumber_polygon_delete', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_aero_polygon_delete', ts, 4, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_airport_point_delete', ts, 64, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_poi_point_delete', ts, 64, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_barrier_polygon_delete', ts, 4, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_place_point_delete', ts, 128, 3, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_admin_linestring_delete', ts, 4, 2, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_airport_polygon_delete', ts, 64, 9, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_barrier_linestring_delete', ts, 4, 14, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_road_geometry_delete', ts, 8, 5, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_landuse_polygon_delete', ts, 8, 5, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_mountain_peak_point_delete', ts, 64, 12, 14)
                UNION
                SELECT * FROM changed_tiles_table('osm_motorway_junction_point_delete', ts, 8, 12, 14)
    );
END;
$$ language plpgsql;
    
CREATE OR REPLACE VIEW osm_tables AS (
        SELECT 'osm_housenumber_point' AS table_name,64 AS buffer_size,14 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_building_polygon' AS table_name,2 AS buffer_size,13 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_poi_polygon' AS table_name,64 AS buffer_size,14 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_water_linestring' AS table_name,8 AS buffer_size,8 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_rail_station_point' AS table_name,64 AS buffer_size,12 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_water_polygon' AS table_name,64 AS buffer_size,5 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_aero_linestring' AS table_name,4 AS buffer_size,9 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_housenumber_polygon' AS table_name,64 AS buffer_size,14 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_aero_polygon' AS table_name,4 AS buffer_size,9 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_airport_point' AS table_name,64 AS buffer_size,9 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_poi_point' AS table_name,64 AS buffer_size,14 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_barrier_polygon' AS table_name,4 AS buffer_size,14 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_place_point' AS table_name,128 AS buffer_size,3 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_admin_linestring' AS table_name,4 AS buffer_size,2 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_airport_polygon' AS table_name,64 AS buffer_size,9 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_barrier_linestring' AS table_name,4 AS buffer_size,14 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_road_geometry' AS table_name,8 AS buffer_size,5 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_landuse_polygon' AS table_name,8 AS buffer_size,5 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_mountain_peak_point' AS table_name,64 AS buffer_size,12 AS min_zoom,14 AS max_zoom
        UNION
        SELECT 'osm_motorway_junction_point' AS table_name,8 AS buffer_size,12 AS min_zoom,14 AS max_zoom
);
