class Change < Hash
  def initialize(coins)
    raise ArgumentError, "Expected Array got #{coins.class}" if !coins.is_a? Array
    raise ArgumentError, "Expected Array of Integers."  unless coins.all?{|coin| coin.is_a? Integer}

    coins.each{|coin| self[coin] = 0}
  end

  def add(coin)
    raise ArgumentError, 'Unkown Coin' unless keys.include?(coin)
    merge(coin => self[coin] + 1)
  end

  def count_coins
    values.reduce(:+)
  end

  def value
    map { |face_value, number| face_value * number }.reduce(:+)
  end
end
