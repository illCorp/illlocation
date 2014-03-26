# Illlocation
Rails Engine with location services using PostGIS.

## Requirements
* Rails Application must use 4.0.3 or later.
* Postgres database ('pg' and 'activerecord-postgis-adapter' gems in Gemfile)
* postgis adapter in *database.yml*

## Setup
### 1. Reference the engine in the *Gemfile* of your Rails application
````
gem 'illlocation', git: "git@github.com:illCorp/illlocation.git"
````

### 2. Bundle
````
bundle install
````

### 3. Mount the engine in *routes.rb*
````
SharknadoTracker::Application.routes.draw do
  get "home/index"
  root "home#index"
  
  mount Illlocation::Engine => "/illlocation"
end
````

### 4.  Copy engine migrations and run on your database
````
rake illlocation:install:migrations
rake db:migrate SCOPE=illlocation
````

### 5.  You should have a Location and Checkin models
````
rails console
2.1.0 :006 > Illlocation::Checkin.count
   (3.8ms)  SELECT f_geometry_column,coord_dimension,srid,type FROM geometry_columns WHERE f_table_name='illlocation_checkins'
   (0.6ms)  SELECT COUNT(*) FROM "illlocation_checkins"
 => 0
````

## Models
* **Checkin**: A geographic point that is locatable
````
{"id"=>1, "locatable_id"=>1, "locatable_type"=>"User", "created_at"=>nil, "updated_at"=>nil, "latitude"=>"39.9319", "longitude"=>"105.0658", "latlon"=>#<RGeo::Geographic::SphericalPointImpl:0x82df9ddc "POINT (105.0658 39.9319)">}
````
* **Location**: a geographic point with a radius
````
{"id"=>1, "latitude"=>"39.9319", "longitude"=>"105.0658", "latlon"=>#<RGeo::Geographic::SphericalPointImpl:0x82d844d8 "POINT (105.0658 39.9319)">, "altitude"=>"1724", "created_at"=>Wed, 26 Mar 2014 05:26:50 UTC +00:00, "updated_at"=>Wed, 26 Mar 2014 05:26:50 UTC +00:00, "radius"=>400}
````
* **CheckinAttribute**: belongs to a checkin, something you may want to display along with a pin on a map Ex: {:avatar_url => "http://sharknado_tracker.org/users/mike"}
* **Tag**: belongs to a location. Ex: gas station, taco stand 

## Usage
**TODO: show some common usage**

## Example
*To be done:* This [sharknado tracker app](https://github.com/illCorp/sharknado_tracker) demonstrates some common usage.

## Contributing
Our goal with this project was to quickly extract and refactor some common location related code that is in several projects.  We're not sure how much time we'll spend maintaining and we may get more formal about the contribution process later.  For now - send us anything.
	
## License
This project rocks and uses MIT-LICENSE.