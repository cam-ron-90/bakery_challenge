require "csv"
require_relative 'bakery_helper'

begin
  require_relative "../lib/models/bakery"
rescue LoadError
end

class Helper
  def self.write_csv(file, data)
    CSV.open(file, 'w') do |csv|
      csv << ["name", "code"]
      data.each do |row|
        csv.puts(row)
      end
    end
  end
end

bakery_helper = BakeryHelper.new(
  file_name: "bakery",
  class_name: "Bakery"
)

describe "Bakery", unless: bakery_helper.file_and_class_valid? do
  it '`bakery.rb` file should exist' do
    expect(bakery_helper.file_exists?).to be(true)
  end

  it '`Bakery` class should be defined' do
    expect(bakery_helper.class_defined?).to be(true)
  end
end

describe "Bakery", if: bakery_helper.file_and_class_valid? do
  let(:recipes) do
    [
      [ "Vegemite Scroll", "VS5"],
      [ "Blueberry Muffin", "MB11" ],
      [ "Croissant", "CF" ]
    ]
  end

  let(:csv_path) { "spec/products.csv" }

  describe "with CSV" do
    # On setup reset csv file with recipes
    before do
      Helper.write_csv(csv_path, recipes)
      @bakery = Bakery.new(csv_path)
    end

    describe '#initialize' do
      it 'should have loaded existing products in spec/products.csv' do
        expect(@bakery.all.length).to eq 3
      end
    end

    describe '#all' do
      it "should give access to all products" do
        expect(@bakery).to respond_to :all
        expect(@bakery.all).to be_a Array
      end
    end
  end
end
