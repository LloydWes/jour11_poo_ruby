require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'


def make_player
  Player.new(gets.chomp)
end

def perform

  puts "Player 1 donne un nom à ton combattant"
  print ">"
  player1 = make_player

  puts "Player 2 donne un nom à ton combattant"
  print ">"
  player2 = make_player

  while player1.is_alive? && player2.is_alive?
    puts "Voici l'état de chaque joueur :"
    player1.show_state
    puts ""
    player2.show_state
    puts ""
    puts "Passons à la phase d'attaque :"
    player1.attack(player2) if player1.is_alive?
    player2.attack(player1) if player2.is_alive?
    puts ""
  end
end

perform