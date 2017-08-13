class Room

  attr_accessor(:number, :guests, :capacity, :songs, :price, :log)

  def initialize(number, guests, capacity, songs, price)
    @number = number
    @guests = guests
    @capacity = capacity
    @songs = songs
    @price = price
    @log = Hash.new {}
    @capacity.times do
        @log[:bed] = [0, 0, 0, 0, 0, 0, 0]
    end
  end

  def price
    return @price
  end

  def full?
    @guests.length == @capacity ? true : false
  end

  def beds_left
    return @capacity - @guests.length
  end

  def view_log
    return @log
  end

  def add_song(name, artist, genre, length)
    song = Song.new(name, artist, genre, length)
    @songs.push(song)
  end

  def remove_song(song)
    @songs.delete(song)
  end

  def play_song(song)
    return "Song not found." if !@songs.include?(song)
    return "Now playing #{song.name} by #{song.artist}!"
  end

  def recommend_song(guest)
    return if !@guests.include?(guest)
    song = @songs.find {|s| s.genre == guest.fav_genre}
    return "#{guest.name}, why not listen to #{song.name}?"
  end


end
