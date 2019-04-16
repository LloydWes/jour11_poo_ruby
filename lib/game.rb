require_relative './player'
class Game
  attr_accessor :human_player, :enemies_in_sight, :ennemies_name
  def initialize(name)
    @human_player = HumanPlayer.new(name)
    @enemies_in_sight = Array.new
    @ennemies_name = Array.new
    make_enemies(4)
  end

  def attack(enemy_indice)
    enemy = enemies_in_sight[enemy_indice]
    kill_player(enemy) if @human_player.attack(enemy) <= 0 #Si le joueur est mort on l'enleve du tableau
  end
  def get_damage(damage)
    @human_player.get_damage(damage)
  end

  def show_players #Consigne cours
    show_human_state
    show_enemies_state
  end
  def show_human_state
    @human_player.show_state
  end
  def show_enemies_state
    @enemies_in_sight.each do |enemy|
      print "#{enemies_in_sight.index(enemy)} - "
      enemy.show_state
      puts ""
    end
  end
  def show_alternatives
    puts "Quelle action veux-tu effectuer ?"
    puts ""
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner "
    puts ""
    puts "attaquer un joueur en vue : "
  end
  def self.greeting #Consigne cours
    puts "------------------------------------------------"
    puts "|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |"
    puts "|Le but du jeu est d'être le dernier survivant !|"
    puts "-------------------------------------------------"
  end

  def is_still_ongoing? #Consigne cours
    enemies_alive? && @human_player.life_points > 0 
  end

  def make_enemies(nb)
    nb.times do
      @enemies_in_sight << Player.new(make_random_name)
      @ennemies_name << @enemies_in_sight.last.name
    end
  end
  def make_random_name #Juste pour automatiquement créer un nom pour les robots
    first_name_array = ['Jacque', 'Jean-Pierre', 'Jean', 'Elise', 'Jean-Luc', 'Eric']
    last_name_array = ['Cheminade', 'Rafarin', 'Mélanchon', 'Lucet', 'Lasalle', 'Ciotti']
    first_name = nil
    last_name = nil
    loop do
      first_name = first_name_array[rand(0...first_name_array.length)]
      last_name = last_name_array[rand(0...last_name_array.length)]
      break if !@ennemies_name.include?("#{first_name} #{last_name}")
    end
    "#{first_name} #{last_name}"
  end

  def menu_choice(entry) #Consigne cours
    case entry
    when 'a'
      @human_player.search_weapon
    when 's'
      @human_player.search_health_pack
    else
      entry = entry.to_i
      if entry < enemies_in_sight.length
        attack(entry)
      else
        puts "Erreur, vous avez essayé d'attaquer un ennemie qui n'existe pas"
        print ">"
        return -1
      end
    end  
  end
  def enemies_attack #Consigne cours
    @enemies_in_sight.each do |enemy|
      enemy.attack(@human_player) if @human_player.is_alive?
    end
  end
  def enemies_alive?
    @enemies_in_sight.length > 0
  end
  def kill_player(player) #Consigne cours
    @enemies_in_sight.delete(player)
  end
end
