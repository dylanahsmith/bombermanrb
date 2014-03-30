module Bomberman
  class Input
    def initialize(socket)
      @socket = socket
    end

    def left
      @socket.write "left\n"
    end

    def right
      @socket.write "right\n"
    end

    def up
      @socket.write "up\n"
    end

    def down
      @socket.write "down\n"
    end

    def bomb
      @socket.write "bomb\n"
    end
  end
end
