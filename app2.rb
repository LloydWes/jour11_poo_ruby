require 'bundler'
Bundler.require

require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'
# import 'time'

# def enemies_alive(enemies_array)
#   at_least_one_alive = false
#   enemies_array.each do |enemy|
#     at_least_one_alive = true if enemy.is_alive?
#   end
#   at_least_one_alive
# end

def perform
  enemies = Array.new

  puts "------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"

  #Création du perso
  puts "Donne un nom à ton perso (HumanPlayer)"
  print ">"
  human = HumanPlayer.new(gets.chomp)

  puts "Tes pires ennemies (Josiane et José) viennent d'être crée ! GRRrrrr !"
  enemies << Player.new('Josiane')
  enemies << Player.new('José')

  puts "\nLa partie commence\n\n".bold.green
  tours = 1
  while human.is_alive? && enemies.length > 0 #Temps qu'il reste l'humain ou au moins 1 robot
    print "tour n°#{tours}".bold, "--------------------------------------\n"
    human.show_state
    #Affichage du menu
    puts "Quelle action veux-tu effectuer ?"
    puts ""
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts ""
    puts "attaquer un joueur en vue :"
    enemies.each do |enemy| #Pour chaque enemies on affiche son index dans le tableau et son état
      print "#{enemies.index(enemy)} - "
      enemy.show_state
      puts ""
    end
    print ">"
    #On fait une action en fonction de la saisie utilisateur
    entry = gets.chomp
    case entry
    when 'a'
      human.search_weapon
    when 's'
      human.search_health_pack
    else
      entry = entry.to_i #Si c'est pas un caractère on transforme en Integer pour tester les valeurs plus facilement
      if entry < enemies.length
        human.attack(enemies[entry])
      else
        puts "Erreur, vous avez essayé d'attaquer un ennemie qui n'existe pas"
      end
    end
    #Les BOTs attaquent
    puts "\nLes autres joueurs t'attaquent !"
    enemies.each do |enemy| #Les robots attaquent s'il s'ont vivant, s'il sont mort on les supprime du tableau
      if !enemy.is_alive?
        enemies.delete(enemy)
      end
      enemy.attack(human) if human.is_alive? #Le robot n'attaque l'humain que si l'humain est vivant
    end
    tours += 1
  end
  if enemies.length > 0 #Si la partie est finie et qu'il reste des ennemies alors c'est que c'est le joueur qui est mort
    puts "Désolé, tu est mort"
  else
    puts "Bien joué tu as tué tous tes ennemies"
  end
  puts "FIN DE LA PARTIE"
  # enemies_alive(enemies)
end

perform