require("minitest/autorun")
require("minitest/rg")
require_relative("../karaoke_bar")
require_relative("../song")
require_relative("../guest")
require_relative("../room")

class TestKaraokeBar < Minitest::Test

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
  end

  def test_full?
    assert_equal(false, @codeclan.full?)
  end

  def test_beds_left
    assert_equal(1, @codeclan.beds_left)
  end

  def test_create_room
    @codeclan.create_room(4, 50)
    assert_equal(2, @codeclan.rooms.length)
    assert_equal(7, @codeclan.total_capacity)
  end

  def test_check_in_guest_cash
    @codeclan.check_in(@alison, @room1, 2)
    assert_equal(400, @alison.cash)
  end

  def test_check_in_karaokebar_cash
    @codeclan.check_in(@alison, @room1, 3)
    assert_equal(5150, @codeclan.cash)
  end

  def test_check_in_total_guests
    @codeclan.check_in(@alison, @room1, 4)
    assert_equal(3, @codeclan.total_guests.length)
  end

  def test_check_out_room_guests
    @codeclan.check_out(@darren)
    assert_equal([@joy], @room1.guests)
  end

  def test_check_out_total_guests
    @codeclan.check_out(@joy)
    assert_equal([@darren], @codeclan.total_guests)
  end

  def test_find_guest_found
    assert_equal("Darren is in Room 1.",
    @codeclan.find_guest(@darren))
  end

  def test_find_guest_not_found
    assert_equal("There is no guest called Lily at CodeClan Karaoke.",
    @codeclan.find_guest(@lily))
  end

  def test_list_guests
    assert_equal("Name: Joy. Room number: 1. Name: Darren. Room number: 1. ",
    @codeclan.list_guests)
  end

end
