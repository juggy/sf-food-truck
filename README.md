# README

## HOW TO RUN


## ARCHITECTURE OVERVIEW


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
- x.x deploy on heroku
- 0.5 write README
