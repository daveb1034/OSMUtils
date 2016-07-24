#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

# Drop all unused tables to save space and keep the schema clean
# If we only drop the geometry columsn the import-external image
# doesn't get smaller so we need to remove both

# this needs to have the database name turned into a command line parameter
# or the vacummed db needs to be included in the src for this process.

function drop_table() {
    local table_name="$1"
    echo "DROP TABLE $table_name;" | sqlite3 "natural_earth_vector.sqlite"
    echo "DELETE FROM geometry_columns WHERE f_table_name = '$table_name';" \
         | sqlite3 "natural_earth_vector.sqlite"
}

function clean_natural_earth() {
    drop_table 'ne_10m_admin_0_antarctic_claim_limit_lines'
    drop_table 'ne_10m_admin_0_antarctic_claims'
    drop_table 'ne_10m_admin_0_map_subunits'
    drop_table 'ne_10m_admin_0_map_units'
    drop_table 'ne_10m_admin_0_pacific_groupings'
    drop_table 'ne_10m_admin_0_scale_rank'
    drop_table 'ne_10m_admin_0_scale_rank_minor_islands'
    drop_table 'ne_10m_admin_0_countries_lakes'
    drop_table 'ne_10m_airports'
    drop_table 'ne_10m_geography_marine_polys'
    drop_table 'ne_10m_geography_regions_elevation_points'
    drop_table 'ne_10m_geography_regions_points'
    drop_table 'ne_10m_geography_regions_polys'
    drop_table 'ne_10m_glaciated_areas'
    drop_table 'ne_10m_admin_0_boundary_lines_map_units'
    drop_table 'ne_10m_admin_0_boundary_lines_maritime_indicator'
    drop_table 'ne_10m_admin_0_countries'
    drop_table 'ne_10m_admin_0_label_points'
    drop_table 'ne_10m_antarctic_ice_shelves_lines'
    drop_table 'ne_10m_antarctic_ice_shelves_polys'
    drop_table 'ne_10m_coastline'
    drop_table 'ne_10m_geographic_lines'
    drop_table 'ne_10m_lakes_europe'
    drop_table 'ne_10m_lakes_historic'
    drop_table 'ne_10m_lakes_north_america'
    drop_table 'ne_10m_lakes_pluvial'
    drop_table 'ne_10m_land_ocean_label_points'
    drop_table 'ne_10m_land_ocean_seams'
    drop_table 'ne_10m_land_scale_rank'
    drop_table 'ne_10m_minor_islands'
    drop_table 'ne_10m_minor_islands_coastline'
    drop_table 'ne_10m_minor_islands_label_points'
    drop_table 'ne_10m_parks_and_protected_lands_area'
    drop_table 'ne_10m_parks_and_protected_lands_line'
    drop_table 'ne_10m_parks_and_protected_lands_point'
    drop_table 'ne_10m_parks_and_protected_lands_scale_rank'
    drop_table 'ne_10m_playas'
    drop_table 'ne_10m_populated_places_simple'
    drop_table 'ne_10m_ports'
    drop_table 'ne_10m_railroads'
    drop_table 'ne_10m_railroads_north_america'
    drop_table 'ne_10m_reefs'
    drop_table 'ne_10m_rivers_europe'
    drop_table 'ne_10m_rivers_lake_centerlines'
    drop_table 'ne_10m_rivers_lake_centerlines_scale_rank'
    drop_table 'ne_10m_rivers_north_america'
    drop_table 'ne_10m_roads'
    drop_table 'ne_10m_roads_north_america'
    drop_table 'ne_10m_time_zones'
    drop_table 'ne_10m_urban_areas'
    drop_table 'ne_10m_urban_areas_landscan'
    drop_table 'ne_10m_admin_1_states_provinces_lakes_shp'
    drop_table 'ne_10m_admin_1_states_provinces_shp'
    drop_table 'ne_50m_admin_0_boundary_lines_disputed_areas'
    drop_table 'ne_50m_admin_1_states_provinces_shp'
    drop_table 'ne_50m_admin_0_countries_lakes'
    drop_table 'ne_50m_admin_0_map_subunits'
    drop_table 'ne_50m_admin_0_map_units'
    drop_table 'ne_50m_admin_0_pacific_groupings'
    drop_table 'ne_50m_admin_0_scale_rank'
    drop_table 'ne_50m_admin_0_sovereignty'
    drop_table 'ne_50m_admin_0_tiny_countries'
    drop_table 'ne_50m_admin_0_tiny_countries_scale_rank'
    drop_table 'ne_50m_geography_marine_polys'
    drop_table 'ne_50m_geography_regions_elevation_points'
    drop_table 'ne_50m_geography_regions_points'
    drop_table 'ne_50m_geography_regions_polys'
    drop_table 'ne_50m_glaciated_areas'
    drop_table 'ne_50m_admin_0_boundary_map_units'
    drop_table 'ne_50m_admin_0_breakaway_disputed_areas'
    drop_table 'ne_50m_admin_0_countries'
    drop_table 'ne_50m_antarctic_ice_shelves_lines'
    drop_table 'ne_50m_antarctic_ice_shelves_polys'
    drop_table 'ne_50m_coastline'
    drop_table 'ne_50m_geographic_lines'
    drop_table 'ne_110m_admin_0_countries_lakes'
    drop_table 'ne_110m_geography_marine_polys'
    drop_table 'ne_110m_geography_regions_elevation_points'
    drop_table 'ne_110m_geography_regions_points'
    drop_table 'ne_110m_geography_regions_polys'
    drop_table 'ne_110m_glaciated_areas'
    drop_table 'ne_110m_admin_0_map_units'
    drop_table 'ne_110m_admin_0_pacific_groupings'
    drop_table 'ne_110m_admin_0_scale_rank'
    drop_table 'ne_10m_admin_0_disputed_areas'
    drop_table 'ne_10m_admin_0_disputed_areas_scale_rank_minor_islands'
    drop_table 'ne_10m_admin_0_seams'
    drop_table 'ne_10m_admin_0_sovereignty'
    drop_table 'ne_10m_admin_1_seams'
    drop_table 'ne_10m_land'
    drop_table 'ne_10m_ocean_scale_rank'
    drop_table 'ne_110m_admin_0_sovereignty'
    drop_table 'ne_110m_admin_0_tiny_countries'
    drop_table 'ne_110m_admin_1_states_provinces_lakes_shp'
    drop_table 'ne_110m_coastline'
    drop_table 'ne_110m_geographic_lines'
    drop_table 'ne_110m_populated_places'
    drop_table 'ne_110m_populated_places_simple'
    drop_table 'ne_110m_rivers_lake_centerlines'
    drop_table 'ne_110m_admin_0_countries'
    drop_table 'ne_110m_admin_1_states_provinces_lines'
    drop_table 'ne_110m_admin_1_states_provinces_shp'
    drop_table 'ne_110m_admin_1_states_provinces_shp_scale_rank'
    drop_table 'ne_110m_land'
    drop_table 'ne_50m_admin_0_boundary_lines_maritime_indicator'
    drop_table 'ne_50m_admin_1_states_provinces_lakes_shp'
    drop_table 'ne_50m_admin_1_states_provinces_shp_scale_rank'
    drop_table 'ne_50m_lakes_historic'
    drop_table 'ne_50m_land'
    drop_table 'ne_50m_playas'
    drop_table 'ne_50m_populated_places'
    drop_table 'ne_50m_populated_places_simple'
    drop_table 'ne_50m_rivers_lake_centerlines'
    drop_table 'ne_50m_rivers_lake_centerlines_scale_rank'
    drop_table 'ne_50m_urban_areas'

    echo "VACUUM;" | sqlite3 "natural_earth_vector.sqlite"
}

clean_natural_earth