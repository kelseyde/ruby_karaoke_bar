require("minitest/autorun")
require("minitest/rg")
require_relative("../song")
require_relative("../guest")
require_relative("../room")

class TestGuest < Minitest::Test

  def setup
    @joy = Guest.new("Joy", 1985, 300, "Classical", 1)
    @darren = Guest.new("Darren", 1976, 600, "Jazz", 1)
    @lily = Guest.new("Lily", 1990, 250, "Rock", 0)
    @alison = Guest.new("Alison", 1943, 500, "Metal", 0)

    @room1 = Room.new(
      1,
      [@joy, @darren],
      3,
      [@borap, @walk, @moz5],
      50
    )
  end

  def test_attributes
    assert_equal("Joy", @joy.name)
    assert_equal(32, @joy.age)
    assert_equal(300, @joy.cash)
    assert_equal("Classical", @joy.fav_genre)
  end

  def test_can_I_afford?
    result = @alison.can_I_afford?(@room1, 2)
    assert_equal(true, result)
  end




end
