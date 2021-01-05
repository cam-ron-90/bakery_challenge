# Bakery
A little Sinatra web application that allows a user to enter a product code and amount to get a breakdown of the packs and cost.

## Setup

Clone the GitHub repository:
```
git clone git@github.com:cam-ron-90/bakery_challenge.git
```
Change directory into `Bakery Challenge`
```
cd bakery_challenge
```

Install Bundler:

```
gem install bundler
```

Install the Sinatra gem:

```
gem install sinatra
```

Install the gem dependencies for this:

```
bundle install
```

## Testing

Run `rspec` from `bakery_challenge` directory to confirm tests are passing.

## Launching the app

1 - To start the app, run:
```
ruby lib/app.rb
```
2 - Open your browser to:
```
http://localhost:4567/
```
3 - Use the form to select product code and quantity.

4 - This take you to your cart, you can return to home screen to add more to your cart OR leave the page.

## Nice to have :

1. More tests.
2. The ability to add quantities to a product and recalibrate the packs.
