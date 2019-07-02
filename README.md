# Tile Map in a Terminal

![tile map game](https://raw.githubusercontent.com/mishalzaman/terminal-rpg-ruby/master/rpg-tile.png)

- Loads map data from a JSON file
- Displays the map and tiles
- Camera to display a portion of the map
- Performs player collision detection
- Saves player's current position to a file, and loads it

### Future considerations

- Add objects to interact with
- Add enemies to fight

## Setup

Ruby v2.4.6

To run the game, write the following command:

    ruby game.rb

I tested this on a mac. It should work in a Windows Environment, but might be a bit slow. I only tested on a windows VM, so that could be it?

## Controls

### Player

`w` Up

`d` Right

`s` Down

`a` Left

### Menu

`tab` Menu

`w` Up

`s` Down

`enter` Confirm action in menu

### Quit

`q` Down
