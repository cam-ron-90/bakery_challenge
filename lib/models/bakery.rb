require "csv"
require_relative "croissant"
require_relative "blueberry_muffin"
require_relative "vegemite_scroll"

class Bakery
  def initialize(csv_file)
    @products = []
    @csv_file = csv_file
    load_csv
  end

  def all
    @products
  end

  def find(code)
    @products.find { |product| product.code == code }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      element = row[:name].split.each { |el| el.capitalize }.join
      if element == "VegemiteScroll"
        @products << VegemiteScroll.new(row)
      elsif element == "BlueberryMuffin"
        @products << BlueberryMuffin.new(row)
      else
        @products << Croissant.new(row)
      end
    end
  end
end
