require 'bundler'
Bundler.require

require 'pry'

require_relative 'lib/game_bis'
require_relative 'lib/player'
require_relative 'lib/string_mod'


def perform
  n = 1
  Game.greeting
  puts "Donne un nom à ton perso (HumanPlayer)"
  print ">"
  my_game = Game.new(gets.chomp)
  puts "Tes pires ennemies viennent d'être créés ! GRRrrrr !".bg_blue.bold, "Ils sont #{my_game.enemies_in_sight.length}".bg_blue.bold

  while my_game.is_still_ongoing?
    print "\ntour n°#{n}".bold,"----------------------------------------------------"
    puts ""
    my_game.show_alternatives #Afficher les options qui s'offrent au joueur
    my_game.show_players
    print ">"
    loop do #On loop tant que l'entrée de l'utilisateur est invalide
      break if my_game.menu_choice(gets.chomp) != -1
    end
    puts "\nLes autres joueurs t'attaquent !"
    my_game.enemies_attack
    # binding.pry
    n += 1
    my_game.new_players_in_sight
  end
  if my_game.enemies_alive?
    puts "Désolé, tu est mort"
  else
    puts "Bien joué tu as tué tous tes ennemies"
  end
  puts "FIN DE LA PARTIE"
end

perform
