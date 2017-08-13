require_relative("drink")
require_relative("guest")
require_relative("karaoke_bar")

class Bar

  attr_accessor(:drinks, :drinks_sold)

  def initialize(drinks)
    @drinks = drinks
  end

  def add_drink(drink)
    @drinks.push(drink)
  end

  def sell_drink(karaoke_bar, guest, *drinks)
    drinks.each {|drink|
      if !@drinks.include?(drink)
        return "The bar does not have #{drink.name} in stock."
      elsif guest.cash < drink.price
        return "#{guest.name} cannot afford a #{drink.name}."
      else
        guest.cash -= drink.price
        karaoke_bar.cash += drink.price
        @drinks.delete(drink)
        guest.drinks.push(drink)
      end
    }
  end


end
