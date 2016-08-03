# Tile Map in a Terminal

![tile map game](https://raw.githubusercontent.com/mishalzaman/terminal-rpg-ruby/master/rpg-tile.png)

Learning Ruby and decided to create a game sort of thing on a terminal. It currently has the following features:

- Loads map data from a JSON file
- Displays the map and tiles
- Camera to display a portion of the map
- Has player collision detection
- Save player's current position to a file, and load it

In the future I will add other features to it, such as having a purpose. Ha!

Anyway check it out, fork it. Let me know how I can improve my Ruby code.

## Setup

Ruby v2.3.1 (Using Rbenv to manage Ruby versions)

To run the game, cd in the directory and ...

    ruby Game.rb

I tested this on a mac. It should work in a Windows Environment, but might be a bit slow. I only tested on a windows VM, so that could be it?

## Controls

Really basic controls to control the player character(Pr)

`w` Up

`d` Right

`s` Down

`a` Left

`tab` Menu

`enter` Confirm action in menu
