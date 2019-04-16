require 'bundler'
Bundler.require

require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/string_mod'


def make_player
  Player.new(gets.chomp)
end

def pause
  puts %Q(Veuillez saisir "entrée" afin de continuer)
  gets.chomp
end

def perform
  #Création perso 1
  puts "Player 1 donne un nom à ton combattant"
  print ">"
  player1 = make_player

  #Création perso 2
  puts "Player 2 donne un nom à ton combattant"
  print ">"
  player2 = make_player

  puts "\nLa partie commence\n\n".bold.green
  tours = 1

  while player1.is_alive? && player2.is_alive?
    print "tour n°#{tours}".bold, "--------------------------------------\n"
    puts "Voici l'état de chaque joueur :"
    player1.show_state
    puts ""
    player2.show_state
    puts ""
    puts "-->Passons à la phase d'attaque :"
    player1.attack(player2) if player1.is_alive?
    player2.attack(player1) if player2.is_alive?
    puts ""
    tours += 1
    pause
  end
  puts "#{player1.name} est le grand vainqueur de ce combat" if player1.is_alive?
  puts "#{player2.name} est le grand vainqueur de ce combat" if player2.is_alive?
end

perform