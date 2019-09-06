# README

## HOW TO RUN

You can access a running app on Heroku directly here:

https://sf-food-truck.herokuapp.com/

Bear in mind that this is a free Heroku instance that will take some time to start from a cold start.

To run this project, you must:
- clone the repo
  - this will also pull the client submodule
- For rails (backend)
  - run `bundle install`
  - next configure the db with `rake db:create db:migrate`
  - load the data into the development db with `SOURCE_URL=https://data.sfgov.org/resource/rqzj-sfat.json rake food_cart:load`
  - Start rails with `rails s`
- For Ember (frontend)
  - go into the client folder and run `yarn`
  - To start, use `ember s --proxy http://localhost:3000`

## ARCHITECTURE OVERVIEW

I decided to be as straight forward as possible for the sake of simplicity and implementation speed. So it runs a vanilla PG/Rails/Ember stack without trying to do too much.

### BACKEND

There is a Rails app configured as an API endpoint. It stores the data into a PostgreSQL DB with PosGIS for spatial data computation and querying.

The data is loaded from the source using a scheduled rake task `rake food_cart:load` that should be run daily (as the data is modified daily). The task loads the JSON, parses it and saves some data point to the DB. The only computation done is that food items are itemized in pg array column and the longitude latitude is converted into a PostGIS point.

The backend presents a single route to the client which is to get a list of food carts based on a location and radius in km. That endpoint checks for the required params and queries the DB. The records are then converted to JSON using a jbuilder template. The whole process is taking less then 100ms and most of the time less then 50ms. The API is not limiting the numbers of records returned, nor setting a maximum radius for the query. Those 2 would be to investigate if the performance degrades over time/usage (short of changing the storage/querying on both client and backend).

### CLIENT

The client is an Ember application running v3.12 without jQuery. It uses the pod folder structure (my own preference) and angle brackets components. It is composed of a main component that uses Ember Leaflet to render and to interact with the map. Here is what that component does:
- Render the map centered on SF
- Trigger an ember-concurrency task to fetch (using ember-fetch) the data from the backend. The task has a timeout of 500ms and is restartable to create a deboucning behavior so that ideally a single call is done per map move.
- The template then renders those food carts on the map using clusters, markers and popup.
- When the map is moved or zoomed, the center and the radius is calculated and the task is retriggered to fetch new data.

### DEPLOYMENT

It is currently deployed on heroku as a backend and frontend app. This dual app setup is easier because heroku provides free proxying to the api from the client app and both back and front end can be deployed separately.

The backend is using Heroku Scheduler to schedule the data refresh every morning.

## TRADE OFFS

Here are some trade offs for the current architecture/solution to keep everything simple and under my timebox of 8h:

- use ember-cli-deploy lightning and keep both backend and client in a single repository
  - the 2 repo makes it easier to deploy to heroku directly
- provide a dockerfile and docker compose for easier development setup
- use elastic search as storage and search
  - would be able to scale to a much larger data set
  - would handle more load
- On the UI:
  - show the different applicant status (currently it is only showing approved) with markers of different color.
  - show other trucks by the same applicant nerby
  - allow the user to follow its prefered trucks
  - sky is the limit when you have time!

## TIMELOG

- 1.5h create rails app with deps, load data and tests
- 1.5h create the ember app and beasic app layout.
- 0.5 hook up the backend and front end with fetch
- 1.0 Add controller and ember tests
- 0.5 deploy on heroku
- 1.0 write README
