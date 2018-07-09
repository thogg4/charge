# Charge

## Setup
Creating a subscription requires a product name be passed in.
Run `bundle exec rails db:seed` to seed a product with the name of `sample`

## Run app
Run app in the standard rails way with `bundle exec rails server`

## Run billing gateway
I used the provided billing gateway and included it in the root of this project.
It can be run using `ruby billing_gateway.rb` it has a dependency on sinatra.

## Make Requests
Make requests to the subscriptions create endpoint at `localhost:3000/subscriptions`
The request must be a post.
Parameters are `product` (product name), `number` (card number), `name` (name on card), `exp_month` and `exp_year`

Example:

```
{
  "product": "sample",
  "number": "4111111111111111",
  "name": "John Doe",
  "exp_month": "10",
  "exp_year": "2020"
}
```

## Run tests
Tests can be run with the standard rails command: `bundle exec rails test`
