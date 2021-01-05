require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

require_relative "models/bakery"
require_relative "models/cart"

Cart = Cart.new

get '/' do
  @bakery = Bakery.new(File.join(__dir__, 'products.csv'))
  @products = @bakery.all
  erb :home
end

get '/cart' do
  @cart = Cart
  erb :cart
end

post '/orders' do
  @bakery = Bakery.new(File.join(__dir__, 'products.csv'))
  @product = @bakery.find(params[:code])

  redirect to '/code_error' if @product.nil?

  @qty = params[:qty].to_i

  if confirm_qty(@qty, @product)
    @results = results(@product)
    Cart.add([[@qty, params[:code], "$#{total_price(@product)}"], @results])
    redirect to '/cart'
  else
    redirect to '/qty_error'
  end
end

get '/qty_error' do
  @bakery = Bakery.new(File.join(__dir__, 'products.csv'))
  @products = @bakery.all
  @error = "Quantity not available, we have these packs"
  erb :qty_error
end

get '/code_error' do
  @bakery = Bakery.new(File.join(__dir__, 'products.csv'))
  @products = @bakery.all
  @error = "Invalid product code"
  erb :code_error
end

def confirm_qty(qty, product)
  @packs = 1
  @sets = []
  until !@sets.empty? || @packs > qty
    @sets = find_sets(qty, product)
    @packs += 1
  end
  @packs < qty
end

def total_price(product)
  @sets.first.map { |qty| product.packs[qty] }.sum.round(2)
end

def results(product)
  @sets.first.group_by(&:itself).map do |k, v|
    "#{v.length} x #{k} $#{product.packs[k]}"
  end
end

def find_sets(qty, product)
  product.packs_amount.repeated_combination(@packs).filter do |num|
    num.sum == qty
  end
end
