# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

* 2.7.1

- System dependencies

* Postgresql

- Configuration

- Database creation

* bundle exec rails db:create

- Database initialization

* rails db:setup

- How to run the test suite

* SIMPLECOV=true bundle exec rake spec

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- API

* Sample Request

```
curl -X POST \
  http://localhost:3000/api/v1/employees/1/assign_gifts \
  -H 'cache-control: no-cache' -H 'content-type: application/json'

```

- Sample Response

```
{"id":17,"employee_id":1,"name":"yoga ball","created_at":"2020-06-27T03:13:59.289Z","updated_at":"2020-06-27T10:15:15.606Z","category_list":["yoga","sitting comfortably"]}
```
