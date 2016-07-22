require 'json'

class Map
	def initialize(map_name)
		
		# loads map data from json file.
		# Has properties:
		# 	map = map array
		# 	width = width of the map
		# 	height = height of the map
		# 	player_x = player's x position
		# 	player_y = player's y position
		@data = load_map(map_name)

		system "clear" or system "cls"

		draw_map
	end

	def draw_map
		@data["map"].each_with_index do | y, index_y |
			y.each_with_index do | x, index_x |
				# Add player position
				if @data['player_x'] == index_x && @data['player_y'] == index_y
					player
					next
				end

				# Add tile
				case x
					when 0
						sea
					when 1
						grass
					when 2
						sand
				end
			end

			# display map information
			case index_y
				when 0
					print " World Map"
				when 1
					print " ---------"
				when 2
					print " player location: #{@data['player_x']}, #{@data['player_y']}"
				when 3
					print " Current tile: #{@data['map'][@data['player_y']][@data['player_x']] }"
			end

			print "\n"
		end		
	end

	def player_move(dir)
		case dir
			when 'right'
				if is_player_collision('x', @data['player_x']+1)
					return
				end
				@data['player_x'] += 1
			when 'left'
				if is_player_collision('x', @data['player_x']-1)
					return
				end
				@data['player_x'] -= 1
			when 'down'
				if is_player_collision('y', @data['player_y']+1)
					return
				end
				@data['player_y'] += 1
			when 'up'
				if is_player_collision('y', @data['player_y']-1)
					return
				end
				@data['player_y'] -= 1
		end  
	end

	private

		def player
			print "#|".bold.bg_gray
		end

		def sea
			print "  ".bg_blue
		end

		def grass
			print "  ".bg_green
		end

		def sand
			print "  ".bg_yellow
		end

		def load_map(map_name)
			file = File.read("assets/#{map_name}.json")

			begin
				return JSON.parse(file)
			rescue 
				puts "Error parsing the map file"
			end
		end

		def is_player_collision(axis, value)
			# Check if player is outside the map bounds
			if is_map_boundary(axis, value)
				return true
			end

			# check what the next tile is 
			if is_valid_tile(axis, value)
				return true
			end

			return false
		end

		def is_map_boundary(axis, value)
			if value < 0
				return true
			end

			case axis
				when 'x'
					return value > @data['width'] ? true : false
				when 'y'
					return value > @data['height'] ? true : false
				else
					return true
			end
		end

		def is_valid_tile(axis, value)
			case axis
				when 'x'
					return @data['map'][@data['player_y']][value] == 0 ? true : false
				when 'y'
					return @data['map'][value][@data['player_x']] == 0 ? true : false
				else
					return true
			end		
		end
end