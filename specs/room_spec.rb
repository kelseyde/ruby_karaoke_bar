require("minitest/autorun")
require("minitest/rg")
require_relative("../song")
require_relative("../guest")
require_relative("../room")

class TestRoom < Minitest::Test

  def setup
    @joy = Guest.new("Joy", 1985, 300, "Classical", 1)
    @darren = Guest.new("Darren", 1976, 600, "Rock", 1)
    @lily = Guest.new("Lily", 1990, 250, "Jazz", 0)
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
  end

  def test_is_full
    assert_equal(@room1.full?, false)
  end

  def test_beds_left
    assert_equal(1, @room1.beds_left)
  end

  def test_view_log
    result = @room1.view_log
    assert_equal(
    {
      bed: [0, 0, 0, 0, 0, 0, 0],
      bed: [0, 0, 0, 0, 0, 0, 0],
      bed: [0, 0, 0, 0, 0, 0, 0]
    },
    result)
  end

  def test_add_song
    @room1.add_song("Waves", "Kanye West", "Hip Hop", 4.23)
    assert_equal(3, @room1.songs.length)
  end

  def test_remove_song
    @room1.remove_song(@borap)
    assert_equal([@walk], @room1.songs)
  end

  def test_play_song_success
    assert_equal("Now playing Walk The Line by Johnny Cash!",
    @room1.play_song(@walk))
  end

  def test_play_song_failure
    assert_equal("Song not found.", @room1.play_song(@moz5))
  end

  def test_recommend_song
    result = @room1.recommend_song(@darren)
    assert_equal(result, "Darren, why not listen to Bohemian Rhapsody?")
  end


end
