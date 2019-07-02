require 'json'

class MapView
    def initialize(map_name)
        # loads map data from json file.
        @data = load_map(map_name)
        @camera_range = 20

        system "clear" or system "cls"

        draw_map
    end

    def draw_map
        clear_terminal

        @data["map"][get_camera_range("y", "down")..get_camera_range("y", "up")].each_with_index do | y, index_y |
            y[get_camera_range("x", "down")..get_camera_range("x", "up")].each_with_index do | x, index_x |

                # Add player position
                if display_player(index_x, index_y)
                    next
                end

                # Add tile
                display_tiles(x)
            end

            # display map information
            display_user_status(index_y)

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

    def get_map_data
        return @data
    end

    private
    # CAMERA
    # ------

    # returns a value that is rounded down or up to the nearest camera range 
    # limiter set by the @camera_range value
    # e.g. if value is 26 and camera range is 20. Then the min value would
    # by 20, and maximum would be 30
    def get_camera_range(axis, direction)
        player = axis == "x" ? @data["player_x"] : @data["player_y"]

        if direction == "down"
            return player - player % @camera_range
        else
            return ((@camera_range - player % @camera_range) + player) - 1
        end
    end

    # DISPLAY
    # -------

    # Draws the player tile on the map based on the tile index view
    def display_player(index_x, index_y)
        x = @data["player_x"] - get_camera_range("x", "down")
        y = @data["player_y"] - get_camera_range("y", "down")


        if x == index_x && y == index_y
            player 
            return true
        end

        return false
    end

    def display_tiles(x)
        case x
            when 0
                sea
            when 1
                earth
            when 2
                wall
            when 3
                sand
            when 4
                bush
            when 5
                bridge
            when 6
                floor
            when 7
                window
            when 8
                sign_post
        end        
    end

    def display_user_status(index_y)
        case index_y
            when 0; print " World Map".blue
            when 1; print " ---------"
            when 2; print " player location: #{@data['player_x']}, #{@data['player_y']}"
            when 3; print " Current tile: #{@data['map'][@data['player_y']][@data['player_x']] }"
            when 4; print ""
            when 5; print " Controls:".blue
            when 6; print " [w] = up, [d] = right, [s] = down, [a] = left".green
            when 7; print " [tab] = menu, [q] = quit".green
        end
    end

    def player 
        print "Pr".bold.bg_gray 
    end

    def sea 
        print "  ".bg_blue
    end

    def earth 
        print "//".blue.bg_green
    end

    def wall
        print "!!".brown.bg_black
    end

    def sand 
        print "  ".bg_yellow
    end

    def bush
        print "|/".brown.bg_green
    end

    def bridge
        print "==".magenta.bg_yellow
    end

    def floor
        print "..".gray.bg_yellow
    end

    def window
        print "//".gray.bg_blue
    end

    def sign_post
        print "|#".bg_green
    end

    # LOAD MAP
    # --------
    # Load map data from a JSON file
        def load_map(map_name)
            if File.file?("assets/maps/#{map_name}") == true
                file = File.read("assets/maps/#{map_name}")
            else 
                file = File.read("assets/save/#{map_name}")
            end

            begin
                return JSON.parse(file)
            rescue 
                puts "Error parsing the map file"
            end
        end

    # COLLISION DETECTION
    # -------------------
    # Perform collision detection tests
    # Return true for collision detection
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
        cannot_traverse = [0,2,7]

        case axis
            when 'x'
                return cannot_traverse.include? @data['map'][@data['player_y']][value] 
            when 'y'
                return cannot_traverse.include? @data['map'][value][@data['player_x']]
            else
                return true
        end     
    end

    def clear_terminal
        system "clear" or system "cls"
    end
end