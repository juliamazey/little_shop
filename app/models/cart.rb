class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def total_count
    @contents.sum do |item, quantity|
      quantity.to_i
    end
  end

  def add_item(id)
    amount = @contents[id].to_i
    amount += 1
    @contents[id] = amount.to_s
  end
end
