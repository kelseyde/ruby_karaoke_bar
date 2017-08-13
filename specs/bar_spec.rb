require("minitest/autorun")
require("minitest/rg")
require_relative("../karaoke_bar")
require_relative("../guest")
require_relative("../bar")
require_relative("../drink")
require_relative("../song")


class TestBar < MiniTest::Test

  def setup
    @joy = Guest.new("Joy", 1985, 300, "Classical", 1)
    @darren = Guest.new("Darren", 1976, 600, "Jazz", 1)
    @lily = Guest.new("Lily", 1990, 250, "Rock", 0)
    @alison = Guest.new("Alison", 1943, 500, "Metal", 0)

    @borap = Song.new("Bohemian Rhapsody", "Queen", "Rock", 5.13)
    @walk = Song.new("Walk The Line", "Johnny Cash", "Country", 4.28)
    @moz5 = Song.new("Mozart's 5th", "Mozart", "Classical", 9.99)

    @room1 = Room.new(
      1,
      [@joy, @darren],
      3,
      [@borap, @walk],
      50
    )
    @codeclan = KaraokeBar.new(
      "CodeClan Karaoke",
      [@room1],
      [@joy, @darren],
      3,
      5000
    )

    @tennents = Drink.new("Tennents", "Lager", 3)
    @smirnoff = Drink.new("Smirnoff", "Vodka", 2)
    @kraken = Drink.new("Kraken", "Rum", 5)
    @oj = Drink.new("Orange Juice", "Juice", 1)

    @codebar = Bar.new([@tennents, @smirnoff, @kraken])
  end

  def test_add_drink
    @codebar.add_drink(@oj)
    assert_equal(4, @codebar.drinks.length)
  end

  def test_sell_drink_karaoke_cash
    @codebar.sell_drink(@codeclan, @joy, @tennents)
    assert_equal(5003, @codeclan.cash)
  end

  def test_sell_drink_guest_cash
    @codebar.sell_drink(@codeclan, @joy, @tennents)
    assert_equal(297, @joy.cash)
  end

  def test_sell_drink_guest_drinks
    @codebar.sell_drink(@codeclan, @joy, @tennents)
    assert_equal([@tennents], @joy.drinks)
  end

  def test_sell_drink_bar_drinks
    @codebar.sell_drink(@codeclan, @joy, @tennents)
    assert_equal([@smirnoff, @kraken], @codebar.drinks)
  end

  def test_sell_multiple_drinks
    @codebar.sell_drink(@codeclan, @joy, @tennents, @smirnoff)
    assert_equal(5005, @codeclan.cash)
    assert_equal(295, @joy.cash)
    assert_equal([@tennents, @smirnoff], @joy.drinks)
    assert_equal([@kraken], @codebar.drinks)
  end

end
