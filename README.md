# Flight Booker

This project provides a chance to tackle some advanced forms.  
It builds the first three steps of a typical checkout process of booking a one-way flight.

A typical airline booking flow includes:

* Entering the desired dates / airports and click "Search".

* Choosing from among a list of available flights.

* Entering passenger information for all passengers.

* Filling in the billing information.
   
The last step would be done via intergration of something like
 [the Paypal API](https://www.smashingmagazine.com/2011/09/getting-started-with-the-paypal-api/), via the [paypal-express gem](https://github.com/nov/paypal-express), [the paypal-sdk-merchant SDK](https://www.tommyblue.it/2013/07/02/paypal-express-checkout-with-ruby-on-rails-and-paypal-sdk-merchant/), or [stripe](https://docs.stripe.com/checkout/quickstart).  

## This project won't include the last step but will go through the first 3 steps extensively.