require 'oj'
require 'multi_json'

module Bomberman
  class GameState
    attr_accessor :mutex, :turn, :turn_duration, :player_name, :x, :y,
                  :last_x, :last_y, :bombs, :max_bombs, :bomb_radius, :alive,
                  :board, :game_object, :message

    def initialize
      @mutex = Mutex.new
      @watchers = []
    end

    def watch(watcher)
      @watchers << watcher
    end

    def notify_watchers
      @watchers.each(&:call)
    end

    def read(io)
      line = io.readline
      return nil unless line
      if (c = io.readchar) != "\n"
        abort("Improperly terminated server message (expected \"\n\" got #{c.inspect}")
      end
      MultiJson.load(line)
    end

    def update(state)
      @mutex.synchronize do
        @turn = state['Turn']
        @turn_duration = state['TurnDuration']
        @player_name = state['Name']
        @x = state['X']
        @y = state['Y']
        @last_x = state['LastX']
        @last_y = state['LastY']
        @bombs = state['Bombs']
        @max_bombs = state['MaxBomb']
        @bomb_radius = state['MaxRadius']
        @alive = state['Alive']
        @board = state['Board']
        @game_object = state['GameObject']
        @message = state['Message']
      end
    end

    def loop(io)
      while !$exit and state = read(io)
        update(state)
        notify_watchers
      end
    end
  end
end
