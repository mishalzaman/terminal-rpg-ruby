#!/usr/bin/env ruby

# Load path for lib directory
$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'lib' ) )

require 'io/console'
require 'string'
require 'map'
require 'context'
require 'menu'

class Game
  def initialize
    @map = Map.new("map.json")
    @context = Context.new
    @menu = Menu.new

    @quit = false

    game_loop
  end

  # The main game loop
  def game_loop
    while @quit == false

      # switch context or game states

      case @context.get_context
        when "movement"
          move = STDIN.getch.chr
          puts move

          case move
            when 'q'
              @quit = true
            when 'd'
              @map.player_move('right')
            when 's'
              @map.player_move('down')
            when 'a'
              @map.player_move('left')
            when 'w'
              @map.player_move('up')
            when 'c'
              @context.switch_context("command")
            when "\t"
              # Menu
              @context.switch_context("menu")
              @menu.reset_selected
              @menu.draw_menu
              next
          end
          @map.draw_map
        when "menu"
          menu = STDIN.getch

          case menu
            when "s"
              @menu.move_cursor("down")
            when "w"
              @menu.move_cursor("up")
            when "\r"
              case @menu.move_cursor("select")
                when "New"
                  @map = Map.new("map.json")
                  @map.draw_map
                  @context.switch_context("movement")
                  next
                when "Save"
                  @menu.save(@map.get_map_data.to_json)
                  puts "Game saved"
                  next
                when "Load"
                  if @menu.can_load == true
                    @map = Map.new(@menu.load)
                    @context.switch_context("movement")
                    @map.draw_map
                  else
                    puts "Coult not find a save game to load"
                  end
                  next
                when "Quit"
                  @quit = true
                  next
              end
            when "\t"
              # Movement
              @context.switch_context("movement")
              @map.draw_map
              next
          end
          @menu.draw_menu
        when "interact"
      end     

      @context.display_context_information
    end

    quit
  end

  def quit
    puts "Game shutting down"
  end
end

Game.new