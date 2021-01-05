class BlueberryMuffin
  attr_reader :name, :code

  def initialize(attr = {})
    @name = attr[:name]
    @code = attr[:code]
  end

  def packs_amount
    [2, 5, 8]
  end

  def packs
    { 2 => 9.95, 5 => 16.95, 8 => 24.95 }
  end
end
