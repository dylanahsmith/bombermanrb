# encoding: utf-8
require 'curses'

module Bomberman
  class GameView
    def initialize(game_state)
      @game_state = game_state
      game_state.watch(self.method(:update))
      init_colours
      display_instructions
    end

    def display_instructions
      Curses.setpos(0, 0)
      Curses.addstr "Controls: arrow keys for movement, space for bomb, Ctrl-C to quit\n"
    end

    CURSOR_INVISIBLE = 0

    def hide_cursor
      Curses.curs_set(CURSOR_INVISIBLE)
    end

    def init_colours
      Curses.start_color
      %w(RED GREEN BLUE YELLOW).each do |name|
        colour = Curses.const_get("COLOR_#{name}")
        Curses.init_pair(colour, colour, Curses::COLOR_BLACK)
      end
      Curses.init_pair(Curses::COLOR_MAGENTA, Curses::COLOR_WHITE, Curses::COLOR_MAGENTA)
    end

    CELLS = {
      "Wall" => ["▓▓", Curses.color_pair(Curses::COLOR_GREEN)|Curses::A_NORMAL],
      "Rock" => ["▓▓", Curses.color_pair(Curses::COLOR_YELLOW)|Curses::A_NORMAL],
      "Ground" => "  ",
      "Bomb" => ["ßß", Curses.color_pair(Curses::COLOR_RED)|Curses::A_NORMAL],
      "PowerUp(Radius)" => ["ⓇⓇ", Curses.color_pair(Curses::COLOR_MAGENTA)|Curses::A_NORMAL],
      "PowerUp(Bomb)" => ["ⒷⒷ", Curses.color_pair(Curses::COLOR_MAGENTA)|Curses::A_NORMAL],
      "Flame" => ["++", Curses.color_pair(Curses::COLOR_RED)|Curses::A_NORMAL],
      "p1" => ["p1", Curses.color_pair(Curses::COLOR_MAGENTA)|Curses::A_NORMAL],
      "p2" => ["p2", Curses.color_pair(Curses::COLOR_MAGENTA)|Curses::A_NORMAL],
      "p3" => ["p3", Curses.color_pair(Curses::COLOR_MAGENTA)|Curses::A_NORMAL],
      "p4" => ["p4", Curses.color_pair(Curses::COLOR_MAGENTA)|Curses::A_NORMAL],
    }

    def display_board(board)
      Curses.setpos(1, 0)
      width = board.size
      height = board[0].size
      height.times do |y|
        width.times do |x|
          cell = board[x][y]
          text, colour = CELLS[cell['Name']]
          text ||= "?#{cell['Name']}?"
          if colour
            Curses.attron(colour) do
              Curses.addstr(text)
            end
          else
            Curses.addstr(text)
          end
        end
        Curses.addstr("\n")
        Curses.refresh
      end
    end

    def update
      display_board(@game_state.board)
    end
  end
end
