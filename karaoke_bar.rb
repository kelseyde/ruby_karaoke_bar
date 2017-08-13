require_relative("room")
require_relative("guest")
require("pry")

class KaraokeBar

  attr_accessor(:name, :rooms, :total_guests, :total_capacity, :cash)

  def initialize(name, rooms, total_guests, total_capacity, cash)
    @name = name
    @rooms = rooms
    @total_guests = total_guests
    @total_capacity = total_capacity
    @cash = cash
  end

  def full?
    @total_guests.length == @total_capacity ? true : false
  end

  def beds_left
    return @total_capacity - @total_guests.length
  end

  def create_room(capacity, price)
    room_number = @rooms.length + 1
    room = Room.new(room_number, [], capacity, [], price)
    @rooms.push(room)
    @total_capacity += room.capacity
  end

  def check_in(guest, room, nights)
    return if room.full?
    return if !guest.can_I_afford?(room, nights)
    guest.cash -= (room.price * nights)
    @cash += (room.price * nights)
    room.guests.push(guest)
    guest.room = room.number
    @total_guests.push(guest)
  end

  def check_out(guest)
    return if !@total_guests.include?(guest)
    for room in @rooms
      room.guests.delete(guest) if room.guests.include?(guest)
    end
    @total_guests.delete(guest)
  end

  def find_guest(guest)
    if !@total_guests.include?(guest)
      return "There is no guest called #{guest.name} at #{@name}."
    else
      for room in @rooms do
        found = room if room.guests.include?(guest)
      end
      return "#{guest.name} is in Room #{found.number.to_s}."
    end
  end

  def list_guests
    list = String.new
    @total_guests.each {|guest|
      list += "Name: #{guest.name}. Room number: #{guest.room.to_s}. "
    }
    return list
  end

end
