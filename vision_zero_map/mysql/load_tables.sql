drop table if exists b_codes;
drop table if exists b_temp_pre;
drop table if exists b_temp_post;
drop table if exists c_temp_pre;
drop table if exists c_temp_post;
drop table if exists boston_bike_infra;
drop table if exists camb_to_2015;
drop table if exists camb_post_2015;
drop table if exists somerville_crashes;
drop table if exists b_incidents;
drop table if exists b_times;
drop table if exists b_locations;
drop table if exists c_crashes;
drop table if exists c_participants;
drop table if exists c_behavior;
drop table if exists c_locations;
drop table if exists c_behavior;
drop table if exists c_bike_involved;
drop table if exists c_ped_involved;
drop table if exists c_street_info;
drop table if exists s_crashes;
drop table if exists s_location;
drop table if exists s_bike_involved;
drop table if exists s_ped_involved;
drop table if exists s_crash_with_injury;

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


create table b_incidents (
    incident_number varchar(20),
    offense_code varchar(10),
    occured_on_date datetime null,
    primary key (incident_number, offense_code)
);
    
create table b_locations (
    incident_number varchar(20),
    street varchar(80) null,
    x_street varchar(80) null,
    district varchar(10) null,
    location varchar(80) null,
    primary key (incident_number)
);      

create table b_codes (
    offense_code varchar(10),
    offense_description varchar(80),
    primary key (offense_code)
);



-- Cambridge related tables					    --
-- 								    --
--     1. historical crash data					    --
--     2. updated crash data					    --
--     3. traffic counts !!!!! - not sure how to implement this yet --

create table c_crashes (
    crash_number int,
    date_time datetime null,
    manner_of_collision varchar(80) null,
    primary key (crash_number)
);

create table c_participants (
    crash_number int,
    object_1 varchar(20) null,
    object_2 varchar(20) null,
    primary key (crash_number)
);

create table c_street_info (
    crash_number int,
    street_number int null,
    street varchar(80) null,
    x_street varchar(80) null,
    at_intersection boolean null,
    primary key (crash_number)
);

create table c_locations (
    crash_number int,
    latitude decimal(10, 8) null,
    longitude decimal(10, 8) null,
    primary key (crash_number)
);

create table c_behavior (
    crash_number int,
    was_distracted boolean null,
    primary key (crash_number)
);

-- Sommerville related tables:			
--     1. somerville motor vehicle crash reports


create table s_crashes (
    id int,
    date_time datetime null,
    primary key (id)
);


create table s_location (
    id int,
    address varchar(80) null,
    latitude decimal(10, 8) null,
    longitude decimal(10, 8) null,
    primary key (id)
);

create table s_crash_with_injury(
    id int,
    primary key (id)
);



-- loading tables into server (localhost for right now)  --

-- load data local infile '../data/somerville/somerville_motor_vehicle_crash_reports.csv'
-- into table somerville_crashes
-- columns terminated by ','
-- optionally enclosed by '"'
-- lines terminated by '\r\n'
-- ignore 1 lines
--     (id, date_time, address, longitude, latitude, weather,
--     road_surface, traffic_dev, intersection_type, @dummy,
--     manner_of_collision, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
--     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
--     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
--     @dummy, @dummy,  bicycle_involved, ped_involved, @dummy, @dummy,
--     @dummy, @dummy, @dummy, injury, @dummy, @dummy, @dummy,
--     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
--     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
--     @dummy, @dummy, @dummy, @dummy, @dummy, notes);

create table c_temp_post (
    crash_number int auto_increment,
    date_time datetime, 
    object_1 varchar(80),
    object_2 varchar(80),
    street_number int,
    street varchar(80),
    x_street varchar(80),
    manner_of_collision varchar(80),
    primary key (crash_number)
);

alter table c_temp_post auto_increment = 1600000815;
 
load data local infile '../data/cambridge/cambridge_crash_data_updated.csv'
into table c_temp_post
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
    (date_time, @dummy, object_1, object_2, street_number, street,
     x_street, @dummy, @dummy, @dummy, 
     @dummy, manner_of_collision, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
     @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
     @dummy, @dummy);
set date_time = str_to_date(@date_time, '%m/%d/%Y %H:%i');


insert ignore into c_crashes(crash_number, date_time, manner_of_collision)
select crash_number, date_time, manner_of_collision
from c_temp_post;


insert ignore into c_participants(crash_number, object_1, object_2)
select crash_number, object_1, object_2
from c_temp_post;

insert ignore into c_street_info(crash_number, street_number, street, x_street, at_intersection)
select crash_number, street_number, street, x_street, @dummy
from c_temp_post;

insert ignore into c_participants(crash_number, object_1, object_2)
select crash_number, object_1, object_2
from c_temp_post;

create table c_temp_pre(
    crash_number int,
    date_time datetime,
    day varchar(20),
    object_1 varchar(20),
    object_2 varchar(20),
    street_number int,
    street varchar(20),
    x_street varchar(20),
    _location varchar(80),
    latitude decimal(10,8),
    longitude decimal(10, 8),
    coordinates varchar(80)
);


load data local infile '../data/cambridge/cambridge_crash_data_historical.csv'
into table c_temp_pre
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
    (crash_number, date_time, day, object_1, object_2, street_number,
     street, x_street, _location, latitude, longitude, coordinates);


insert ignore into c_crashes(crash_number, date_time, manner_of_collision) 
select crash_number, date_time, @dummy
from c_temp_pre;


insert ignore into c_participants(crash_number, object_1, object_2)
select crash_number, object_1, object_2
from c_temp_pre;


insert ignore into c_street_info(crash_number, street_number, street, x_street, at_intersection)
select crash_number, street_number, street, x_street, @dummy
from c_temp_pre;

update c_street_info
set at_intersection = true
where street != "" and x_street != "";


insert ignore into c_locations(crash_number, latitude, longitude)
select crash_number, latitude, longitude
from c_temp_pre;

create table b_temp_post (
    incident_number varchar(20),
    offense_code varchar(10),
    offense_code_group varchar(10),
    offense_description varchar(80),
    district varchar(10),
    reporting varchar(10),
    shooting varchar(10),
    occured_on_date datetime,
    _year int,
    _month varchar(20),
    day_week varchar(20),
    _hour int,
    ucr_part varchar(10),
    street varchar(80),
    x_street varchar(10), 
    latitude decimal (10, 8),
    longitude decimal (10, 8),
    location varchar(80)
);


load data local infile '../data/boston/incidents_post_2015.csv'
into table b_temp_post
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines
    (incident_number, offense_code, offense_code_group, offense_description,
    district, reporting, shooting, occured_on_date, _year, _month, day_week,
    _hour, ucr_part, street, @dummy, latitude, longitude, location)
set offense_code = trim(leading '0' from offense_code);



insert ignore into b_incidents(incident_number, offense_code, occured_on_date) 
select distinct incident_number, offense_code, occured_on_date
from b_temp_post;


insert ignore into b_locations (incident_number, street, x_street, district, location)
select incident_number, street, x_street, district, location
from b_temp_post;


create table b_temp_pre (
       incident_number varchar(20),
       offense_code varchar(20) null,
       offense_description varchar(80) null,
       main_crime_code varchar(10) null,
       district varchar(5) null,
       reporting_area varchar(5) null,
       occured_on_date datetime null,
       weapon_type varchar(30) null,
       shooting varchar(5) null,
       domestic varchar(5) null,
       shift varchar(10) null,
       year int null,
       month varchar(16) null,
       day_week varchar(16) null,
       ucr_part varchar(10) null,
       X decimal(10, 4) null,
       Y decimal(10, 4) null,
       street varchar(20) null,
       x_street varchar(20) null,
       location varchar(40) null
);


load data local infile '../data/boston/incidents_pre_2015.csv'
into table b_temp_pre
columns terminated by ','
optionally enclosed by '"'
lines terminated by '\n'
ignore 1 lines
    (incident_number, offense_code, offense_description, main_crime_code,
    district, reporting_area, @occured_on_date, weapon_type, shooting, domestic, shift, 
    year, month, day_week, ucr_part, X, Y, street, x_street, location)
set occured_on_date = str_to_date(@occured_on_date, '%m/%d/%Y %H:%i');

insert ignore into b_codes(offense_code, offense_description)
select main_crime_code, offense_description
from b_temp_pre;

insert ignore into b_incidents(incident_number, offense_code, occured_on_date)
select incident_number, main_crime_code, occured_on_date
from b_temp_pre;

insert ignore into b_locations(incident_number, street, x_street, district, location)
select incident_number, street, x_street, district, location
from b_temp_pre;


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

drop table b_temp_pre;
drop table b_temp_post;
drop table c_temp_pre;
drop table c_temp_post;