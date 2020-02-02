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
