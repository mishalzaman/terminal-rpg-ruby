#!/usr/bin/env ruby

# Load path for lib directory
$LOAD_PATH.unshift( File.join( File.dirname(__FILE__), 'lib' ) )

require 'io/console'
require 'string'
require 'map'

quit = false
@mode = 'movement' # movement or command

map = Map.new("map")

def display_mode_information
	case @mode
		when "movement"
			puts "move".bg_green
		when "command"
			puts "command".bg_magenta
	end
end

# main loop
while quit == false

	# switch between to the main context:
	# 	movement:
	# 		Where the player character can move
	# 		around the map using the wasd keys
	# 	command:
	# 		Where commands are typed by hte player 
	if @mode == "movement"
		move = STDIN.getch
	
		case move
			when 'q'
				quit = true
			when 'd'
				map.player_move('right')
			when 's'
				map.player_move('down')
			when 'a'
				map.player_move('left')
			when 'w'
				map.player_move('up')
			when 'c'
				@mode = "command"
		end
	else 
		command = gets.chomp

		case command
			when 'move'
				@mode = "movement"
			when 'q'
				quit = true
		end 
	end

	system "clear" or system "cls"
	map.draw_map
	display_mode_information
end



