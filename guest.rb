require_relative("room")

class Guest

  attr_accessor(:name, :age, :cash, :fav_genre, :drinks, :room)

  def initialize(name, dob, cash, fav_genre, room)
    @name = name
    @age = 2017 - dob
    @cash = cash
    @fav_genre = fav_genre
    @drinks = []
    @room = room
  end

  def can_I_afford?(room, nights)
    @cash >= (room.price * nights) ? true : false
  end

end
