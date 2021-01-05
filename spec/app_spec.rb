begin
  require_relative "../lib/app"
  require_relative "../lib/models/croissant"
  require_relative "../lib/models/blueberry_muffin"
  require_relative "../lib/models/vegemite_scroll"
  require_relative "../lib/models/bakery"
rescue LoadError
end

describe "#confirm_qty" do
  let(:bakery) { Bakery.new("spec/products.csv") }

  it "should return true for order if quantity is valid for VS5" do
    expect(confirm_qty(13, bakery.find("VS5"))).to eq(true)
  end
  it "should return false for order if quantity is valid for VS5" do
    expect(confirm_qty(2, bakery.find("VS5"))).to eq(false)
  end
end
