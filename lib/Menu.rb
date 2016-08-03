class Menu
  def initialize
    @save_file_directory = "assets/save"
    @selected = 0
    @menu_items = ["New", "Save", "Load", "Quit"]
    @items = @menu_items.count
    @load_files = Dir.entries("assets/save").select {|f| !File.directory? f}
  end

  # Draw
  def draw_menu
    clear_terminal
    @menu_items.each_with_index do |k, index|
      if @selected == index
        puts "   > #{k}                             ".green
      else
        puts "  #{k}                                "
      end
    end
  end 

  # Menu user interaction
  def move_cursor(direction)
    case direction
      when "down"
        @selected += 1

        if @selected >= @items
          @selected = @items - 1
        end
      when "up"
        @selected -= 1

        if @selected < 0
          @selected = 0
        end   
      when "select"
        return @menu_items[@selected]
    end       
  end

  def reset_selected
    @selected = 0
  end

  # Save functonality
  def save(data)
    File.open("assets/save/save.json", "w+") do |f|
      f.puts(data)
    end
  end

  # Load functionality
  def can_load
    if @load_files.count > 0
      return true
    end

    return false
  end

  def load
    return "save.json"
  end

    def clear_terminal
        system "clear" or system "cls"
    end
end