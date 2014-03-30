require 'bomberman'
require 'socket'

socket = TCPSocket.new('localhost', 40000)

state = Bomberman::GameState.new(socket)
state.watch(proc {
  puts "turn=#{state.turn}, position=(#{state.x}, #{state.y})"
})

controller = Bomberman::Controller.new(socket)
state.next_turn
controller.up
state.next_turn
controller.bomb
state.next_turn
controller.down
state.next_turn
controller.left
state.next_turn
