require 'pry'

require_relative 'lib/game'
require_relative 'lib/player'
# import 'time'

def enemies_alive(enemies_array)
  at_least_one_alive = false
  enemies_array.each do |enemy|
    at_least_one_alive = true if enemy.is_alive?
  end
  at_least_one_alive
end

def perform
  enemies = Array.new

  puts "------------------------------------------------"
  puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
  puts "|Le but du jeu est d'être le dernier survivant !|"
  puts "-------------------------------------------------"

  puts "Donne un nom à ton perso (HumanPlayer)"
  print ">"
  human = HumanPlayer.new(gets.chomp)
  puts "Tes pires ennemies (Josiane et José) viennent d'être crée ! GRRrrrr !"
  enemies << Player.new('Josiane')
  enemies << Player.new('José')

  while human.is_alive? && enemies_alive(enemies)
    human.show_state
    puts "Quelle action veux-tu effectuer ?"
    puts ""
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts ""
    puts "attaquer un joueur en vue :"
    enemies.each do |enemy|
      print "#{enemies.index(enemy)} - "
      enemy.show_state
      puts ""
      #{enemy.name} a #{enemy.life_points} points de vie""
    end
    print ">"
    entry = gets.chomp
    case entry
    when 'a'
      human.search_weapon
    when 's'
      human.search_health_pack
    else
      entry = entry.to_i
      if entry < enemies.length
        human.attack(enemies[entry])
      else
        puts "Erreur, vous avez essayé d'attaquer un ennemie qui n'existe pas"
      end
    end    
    puts "\nLes autres joueurs t'attaquent !"
    enemies.each do |enemy|
      if !enemy.is_alive?
        enemies.delete(enemy)
      end
      enemy.attack(human) if human.is_alive?
    end
    # binding.pry
    puts "----------------------------------------------------"
  end
  if enemies_alive(enemies)
    puts "Désolé, tu est mort"
  else
    puts "Bien joué tu as tué tout tes ennemies"
  end
  puts "FIN DE LA PARTIE"
  # enemies_alive(enemies)
end

perform