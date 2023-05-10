# GET '/' Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

You'll need to include:
  * the HTTP method
  * the path
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

Method: GET
Path: /
No params

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- Response: 200 OK -->

<html>
  <head>
    <title>Chitter</title>
  </head>
  <body>
    <h1>What's peeping?</h1>
    <div>Peep 1</div>
    <div>Peep 2</div>
    <div>Peep 3</div>
  </body>
</html>
```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /

# Expected response:

Response for 200 OK

<html>
  <head>
    <title>Chitter</title>
  </head>
  <body>
    <h1>Welcome to Chitter!</h1>
    <h2>What's peeping?</h2>
    <div>Peep 1</div>
    <div>Peep 2</div>
    <div>Peep 3</div>
  </body>
</html>
```


## 4. Encode as Tests Examples

```ruby
# file: spec/integration/app_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns list of all peeps with 200 OK' do
      response = get('/')

      expect(response.status).to eq(200)
      expect(response.body).to include('<title>Chitter</title>')
      expect(response.body).to include("<h2>What's peeping?</h2>")
      expect(response.body).to include("test post please ignore")
      expect(response.body).to include("Everyone should peep.")
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
