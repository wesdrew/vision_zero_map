drop table if exists b_crime_pre;
drop table if exists b_crime_post;
drop table if exists b_codes;
drop table if exists boston_bike_infra;
drop table if exists camb_to_2015;
drop table if exists camb_post_2015;
drop table if exists somerville_crashes;


-- boston related tables:				      --
--        1. crime reports, including crash reports.	      --
--        (keeping all information in case we extend map)     --
--        2. crime codes - maps codes to offense descriptions --
--        3. existing bike infrastructure		      --

       


create table boston_bike_infra(
    fid integer,
    objectid integer,
    street varchar(80),
    road_invent int,
    functional int,
    jurisdiction int,
    network int,
    installed int,
    exis_facil varchar(10),
    road smallint,
    divided smallint,
    travel_lane smallint,
    one_way varchar(8),
    lts smallint,
    phase smallint,
    shape_length decimal(10, 8),
    shape__length decimal(10,9),
    primary key (fid)     
);


create table b_crime_pre (
    incident_number varchar(20),
    offense_description varchar(80) null,
    occured_on_date varchar(20) null,
    year smallint null,
    month smallint null,
    day_week varchar(20) null,
    X decimal(11, 4) null,
    Y decimal(10, 3) null,
    street varchar(80) null,
    x_street varchar(80) null,
    location varchar(80) null,
    primary key (incident_number)
);

create table b_crime_post (
    incident_number varchar(20),
    offense_code integer null,
    offense_code_group varchar(80) null,
    offense_description varchar(80) null,
    occured_on_date datetime null,
    year smallint null,
    month smallint null,
    day_week varchar(20) null,
    hour smallint null,
    street varchar(80) null,
    latitude decimal(10, 8) null,
    longitude decimal(10, 8) null,
    location varchar(80) null,
    primary key (incident_number)
);

create table b_codes (
    offense_code integer,
    offense_description varchar(80),
    primary key (offense_code)
);



-- Cambridge related tables					    --
-- 								    --
--     1. historical crash data					    --
--     2. updated crash data					    --
--     3. traffic counts !!!!! - not sure how to implement this yet --



create table camb_to_2015 (
       crash_number int,
       date_time datetime null,
       day varchar(20) null,
       object_1 varchar(20) null,
       object_2 varchar(20) null,
       street_number int null,
       street varchar(80) null,
       x_street varchar(80) null,
       location varchar(80) null,
       latitude decimal(10, 8) null,
       longitude decimal(10, 8) null,
       primary key (crash_number)
);

create table camb_post_2015 (
       date_time datetime,
       day varchar(20) null,
       object_1 varchar(20) null,
       object_2 varchar(20) null,
       street_number int null,
       street_name varchar(80) null,
       x_street varchar(80) null,
       location varchar(80) null,
       may_involve_bike boolean null,
       may_involve_ped boolean null,
       manner_of_collision varchar(80) null,
       ambient_light varchar(80) null,
       traffic_device varchar(80) null,
       traffic_dev_function varchar(80) null,
       road_cond varchar(80) null,
       road_junc_type varchar(80) null,
       speed_limit int null,
       v_1_is_truck char null,
       v_1_is_bus char null,
       v_1_driver_distracted char null,
       v_2_is_truck char null,
       v_2_is_bus char null,
       v_2_is_driver_distracted char null,
       primary key (date_time)
);




-- Sommerville related tables:			
--     1. somerville motor vehicle crash reports


-- some problem with how this is loading plus road surface and traffic dev are not varchar!
create table somerville_crashes (
    id int,
    date_time datetime null,
    address varchar(80) null,
    longitude decimal(10, 8) null,
    latitude decimal(10, 8) null,
    weather varchar(80) null,
    road_surface varchar(80) null,
    traffic_dev varchar(80) null,
    intersection_type varchar(80) null,
    manner_of_collision varchar(80) null,
    bicycle_involved smallint null,
    ped_involved smallint null,
    injury smallint null,
    notes text null,
    primary key (id)
);    





-- loading tables into server (localhost for right now)  --


load data local infile '../data/somerville/somerville_motor_vehicle_crash_reports.csv'
into table somerville_crashes
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
    (id, date_time, address, longitude, latitude, weather,
    road_surface, traffic_dev, intersection_type, @dummy,
    manner_of_collision, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
    @dummy, @dummy,  bicycle_involved, ped_involved, @dummy, @dummy,
    @dummy, @dummy, @dummy, injury, @dummy, @dummy, @dummy,
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
    @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
    @dummy, @dummy, @dummy, @dummy, @dummy, notes);
 
load data local infile '../data/cambridge/cambridge_crash_data_updated.csv'
into table camb_post_2015
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
    (date_time, day, object_1, object_2, street_number, street_name,
     x_street, @dummy, location, may_involve_bike, 
     may_involve_ped, manner_of_collision, @dummy,
     @dummy, ambient_light, @dummy, @dummy, traffic_device,
     traffic_dev_function, road_cond, road_junc_type, @dummy,
     @dummy, @dummy, speed_limit, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
     v_1_is_truck, @dummy, v_1_is_bus, @dummy, @dummy,
     v_1_driver_distracted, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, v_2_is_truck, @dummy, v_2_is_bus,
     @dummy, @dummy, v_2_is_driver_distracted, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy);
   



load data local infile '../data/cambridge/cambridge_crash_data_historical.csv'
into table camb_to_2015
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
    (crash_number, date_time, day, object_1, object_2, street_number,
     x_street, location, latitude, longitude, @dummy);

load data local infile '../data/boston/incidents_post_2015.csv'
into table b_crime_post 
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
    (incident_number, offense_code, offense_code_group, offense_description,
    @dummy, @dummy, @dummy, occured_on_date, year, month, day_week,
    hour, @dummy, street, latitude, longitude, location);

load data local infile '../data/boston/incidents_pre_2015.csv'
into table b_crime_pre
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines
    (incident_number, @dummy, offense_description, @dummy,
    @dummy, @dummy, @occured_on_date, @dummy, @dummy, @dummy, @dummy, 
    year, month, day_week, @dummy, X, Y, street, x_street, location)
set occured_on_date = str_to_date(@occured_on_date, '%m/%d/%Y');



load data local infile '../data/boston/rmsoffensecodes.csv'
into table b_codes
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;

load data local infile '../data/boston/boston_existing_bike_network.csv'
into table boston_bike_infra
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;