class Cart
  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def total_count
    @contents.sum do |item, quantity|
      quantity.to_i
    end
  end
end
