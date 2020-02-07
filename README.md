# Startup application

## Requirements

```
elixir 1.10.0
erlang 22.2.4
phoenix 1.4.12
postgresql 11.6
```
- How to install erlang with asdf [asdf erlang](https://github.com/asdf-vm/asdf-erlang)
- How to install elixir with asdf [asdf elixir](https://github.com/asdf-vm/asdf-elixir)
- How to install Phoenix [documentation](https://hexdocs.pm/phoenix/installation.html)



```
# for development/demonstratoin purpose only!

psql user:      rocker_user
psql password:  rocker

user must be allowed to create databases and tables
```

## How to start project

```
$ git clone git@github.com:lyo5ha/rocker_assignment.git
$ mix deps.get
$ mix ecto.create
$ mix ecto.migrate

$ mix phx.start
```
Server will be available on `localhost:4000/`


# API endpoins/examples

## Create new loan
For demonstration purpose assumed that "amount" field is always in integer format and represents loan amount in cents.

#### POST request to `/api/v1/loan/new`

``` json
Content-Type: application/json

{
  "jsonapi": {
    "version": "1.0"
  },
  "data": {
    "type": "loan",
    "amount": 3056,
    "status": "NEW",
    "user": {
      "name": "Jhon Jhonson",
      "phone": "+3827777777",
      "email": "hello@hello.com"
    }
  }
}

```

#### Responses

``` json
HTTP/1.1 200 OK
Content-Type: application/json

{
  "jsonapi": {
    "version": "1.0"
  },
  "data": {
    "type": "loan",
    "id": "101",
    "status": "ACCEPTED",
    "rate": 5.5
  }
}

```

``` json
HTTP/1.1 200 OK
Content-Type: application/json

{
  "jsonapi": {
    "version": "1.0"
  },
  "data": {
    "type": "loan",
    "id": "101",
    "status": "REJECTED",
    "rate": null
  }
}

```

``` json
HTTP/1.1 422 Unprocessable Entity
Content-Type: application/json

{
  "jsonapi": {
    "version": "1.0"
  },
  "errors": [
    {
      "status": "422",
      "source": "/api/v1/loan/new",
      "title": "Invalid Attribute",
      "detail": "Invalid email address"
    }
  ]
}

```

## List all loans
#### GET request to `/api/v1/loan/all`

#### Response

``` json
HTTP/1.1 200 OK
Content-Type: application/json

{
  "jsonapi": {
    "version": "1.0"
  },
  "data": [
    {
      "type": "loan",
      "amount": "3056",
      "id": "101",
      "user": {
          "name": "Jhon Jhonson",
          "phone": "+3827777777",
          "email": "hello@hello.com"
       },
      "status": "ACCEPTED",
      "rate": 5.5
    },
    {
      "type": "loan",
      "amount": "4057",
      "id": "102",
      "user": {
          "name": "Jack Jackson",
          "phone": "+3829999999",
          "email": "buybuy@buybuy.com"
      },
    "status": "ACCEPTED",
    "rate": 5.3
    },
    {
      "type": "loan",
      "amount": "5059",
      "id": "103",
      "user": {
          "name": "Bill Billson",
          "phone": "+38233333333",
          "email": "morning@morning.com"
      },
      "status": "REJECTED"
     }
  ]
}

```

# Realization notes

## Validations

Fields should be present and be in correct format:
- name
- email
- phone

One email should be connected with one name.

## Prime numbers check

  There is a implementation of Solovay–Strassen primality test,
  which is  probabilistic. Chance of wrong answer with 30 iterations
  will be 1 of 1073741824, which could be considered as sufficient.
  Running time will be O(k·log^3 n), k=30.

## Loan amounts

  Highest loan amount form all requests keeps in Genserver in-memory.
  When application restarts, this highest amount resets to 0. Then first loan
  amount writes as highest.


# Technical Assignment - Elixir

FooBank, a fictional financial services company, based in Athens,
Greece, earns its money by offering loans to people who need to
finance expensive purchases.

Their most recent product is a mobile app where people can apply for
loans. Unfortunately the agency brought in completely forgot to build
a back-end for the service and for this reason you have been asked to
build one.

Please email a link to a code repository or send a .zip/.tar file with
the code to tiffanylopezlee@bynk.se when you feel you have a good
solution.

## The API

**Creating loan applications**

Customer's will apply by sending an HTTP request containing;
1. The requested loan amount
2. The name of the person applying for the loan
3. Their phone number
4. Their email

As a response the app receives a status indicating if the application
was rejected or accepted and the rate if the application was accepted

``` json
{ "status": "REJECTED|ACCEPTED", "rate": 5.5 }
```

To the decide if a loan is to be accepted or rejected the bank's
credit regulation is applied.

1. If a loan application has a lower “Requested loan amount” than any
   of the previous loan applications, then the loan is rejected.

2. If a loan application has a Requested loan amount which is a prime
   number, then a loan offer is granted with interest rate of 9.99%

3. Otherwise, a loan is offered with random interest rate between 4%
   and 12%.

**Listing loan applications**

Calling this endpoint should return a list of all loans, their
statuses and the interest rate offered (if any).
