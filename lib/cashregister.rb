require 'change'

class CashRegister
  attr_accessor :coins

  def coins=(coins=[25,10,5,1])
    raise ArgumentError, "Expected an Array, got #{coins.class.name}" unless coins.is_a? Array
    raise ArgumentError, 'Did not receive an Array of Integers' unless coins.all? { |coin| coin.is_a? Integer }

    @optimal_change = Hash.new { |hash, key| hash[key] = get_optimal_change(key) }
    @coins = coins
  end

  alias :initialize :coins=

    def make_change(amount)
      raise ArgumentError, "Expected Integer, got #{amount.class.name}" unless amount.is_a? Integer

      return @optimal_change[amount]
    end

  private

  def get_optimal_change(amount)
    if amount < @coins.min
      nil
    elsif @coins.include?(amount)
      Change.new(@coins).add(amount)
    else
      @coins.sort.reverse.select do |coin|
        coin < amount
      end.reduce([]) do |coins, coin|
        coins.all? { |larger_coin| larger_coin % coin != 0 } ? coins << coin : coins
      end.map do |coin|
        @optimal_change[amount - coin].add(coin) unless @optimal_change[amount - coin].nil?
      end.compact.select do |change|
        change.value == amount
      end.min do |a,b|
        a.count_coins <=> b.count_coins
      end
    end
  end
end
