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

### 5.  You should have a Location and Checkin table
````
rails console
2.1.0 :006 > Illlocation::Checkin.count
   (3.8ms)  SELECT f_geometry_column,coord_dimension,srid,type FROM geometry_columns WHERE f_table_name='illlocation_checkins'
   (0.6ms)  SELECT COUNT(*) FROM "illlocation_checkins"
 => 0
````

### Models
* Location - a lat, lon, and optional altitude
* Tag - belongs to a location. Ex: gas station, taco stand 
* Checkin - A locatable (Ex: "User", "Tornado", "Airplane") that has a location
* CheckinAttribute - belongs to a checkin, something you may want to display along with a pin on a map Ex: {:avatar_url => "http://sharknado_tracker.org/users/mike"}

## Usage
This [sharknado tracker app](https://github.com/illCorp/sharknado_tracker) demonstrates some common usage.

*More coming soon*

## Discussion 
* How precise should a location be?  Consider tags and checkins.
* Thinking of removing create action from Locations and Checkins controller.  These are pretty plain and more than likely, the host application will be doing this in it's own way - for example, create CheckinAttributes at the same time.  This engine should focus on having a flexible vanialla data model (we're close to there), and then offer some great search features with scoped class methods.  


## Contributing
Our goal with this project was to quickly extract and refactor some common location related code that is in several projects.  We're not sure how much time we'll spend maintaining and we may get more formal about the contribution process later.  For now - send us anything.
	
## License
This project rocks and uses MIT-LICENSE.