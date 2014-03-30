require 'curses'

module Bomberman
  class KeyboardInput < Input
    def initialize(*args)
      super
      Curses.stdscr.keypad = true
    end

    def loop
      until $exit
        self.next
      end
    end

    def next
      case read_key
      when Curses::Key::LEFT
        left
      when Curses::Key::RIGHT
        right
      when Curses::Key::UP
        up
      when Curses::Key::DOWN
        down
      when ' '
        bomb
      end
    end

    def read_key
      Curses.getch
    end
  end
end
