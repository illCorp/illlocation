# Illlocation
Rails Engine with location services using PostGIS.

## Requirements
* Rails Application must use 4.0.3 or later.
* Postgres database ('pg' and 'activerecord-postgis-adapter' gems in Gemfile)

## Setup
### 1. Reference the engine in the *Gemfile* of your Rails application
````
gem 'illlocation', git: "git@github.com:illCorp/illlocation.git"
````

TODO: version management

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

### 5.  You should a Location and Checkin table
````
rails console
2.1.0 :006 > Illlocation::Checkin.count
   (3.8ms)  SELECT f_geometry_column,coord_dimension,srid,type FROM geometry_columns WHERE f_table_name='illlocation_checkins'
   (0.6ms)  SELECT COUNT(*) FROM "illlocation_checkins"
 => 0
````

## Usage
This [app](https://github.com/illCorp/sharknado_tracker) demonstrates some common usage.

*More coming soon*


## License
This project rocks and uses MIT-LICENSE.