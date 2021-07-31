# README

## Interview Type
Systems Design for an Application Software Engineer role.

## Problem Description
<p>Design a system to keep track of how much time a part has spent outside of a refrigerator.
You can assume that all the parts start in the refrigrator. You can also assume that to move
a part from one place to another takes neglible amount of time and that the part is always
scanned the new location.
</p>

<p>
You are in charge of creating a database schema as well as writing 2 functions.

1. UpdateOutTime() which is called whenever the item is scanned.
   The arguments that are passed to it are item_id, location_id and timestamp.
   item_id represents the id of the part being scanned. location_id is the id of the
   location where the part was scanned. timestamp is the time at which the part was scanned.
   I'm simplying the problem further by representing the timestamp in seconds.
   => At time t = 0 seconds, all parts were in the refrigerator. Later on, we can
   make the timestamp a datetime variable.

2. GetOutTime() is a function that gets called when the user wants to see how much time
   has a part spent outside of the refrigerator.

For now I'm going to assume that all the items and location ids are valid.
</p>

## Database Schema

<p>

### CacheTable   
This table caches time spent outside so far, prev location type 
and last scan time for a given item. Queries to it can be made 
faster by adding index on item_id. This database is always going
to be read from and written to so in case writes become a bottleneck
we can change the database from SQL to NoSQL.

item_id: 64 bit int, total_time_outside: 64 bit int, prev_loc_is_freezer: boolean, last_time_stamp: 64 bit int

### LocationTable            
This table is required to check if current location the item was
scanned at was a freezer or not. location_id is a PRIMARY key so
it's already indexed by defualt.

location_id: 64 bit int, is_freezer: boolean
</p>

## Function Implementations Psuedocode
1. UpdateOutTime(item_id, locatiod_id, timestamp) {
    1. Get total_time_outside, prev_location_is_freezer, last_time_stamp from CacheTable using item_id LIMIT 1
    2. Get is_freezer from LocationTable using location_id LIMIT 1
    3. Declare new_total_time 
    4. if prev_location_is_freezer:
          new_total_time = total_time_spent_outside
       else:
          new_total_time = (timestamp - last_time_stamp in seconds) + total_time_outside
    5. Update CacheTable prev_loc_is_freezer with is_freezer 
        AND total_time_outside with new_total_time 
        AND lastTimeStamp With timestamp
} 

2. GetOutTime(item_id) {
    1. return CacheTable.total_time_outside WHERE item_id = item_id LIMIT 1
}

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
