require_relative './string_mod'

class Player
  attr_accessor :name, :life_points
  def initialize(name)
    @name = name
    @life_points = 10
  end
  def show_state()
    if @life_points < 25
      print "#{@name}".bold, " a ", "#{@life_points}".bold.red, " points de vie."
    else

      print "#{@name}".bold, " a ", "#{@life_points}".blue, " points de vie."
    end
  end
  def gets_dammage(damage)
    @life_points -= damage
    if @life_points <= 0
      @life_points = 0 
      puts ""
      puts "☠️  ☠️  ☠️  Le joueur #{@name} a été tué...☠️  ☠️  ☠️".italic.red
    end
    @life_points
  end
  def compute_damage
    rand(1..6)
  end
  def attack(attacked_player)
    damage = compute_damage
    puts "⚔️  #{name} attaque #{attacked_player.name}"
    puts "    Il lui inflige #{damage} points de dégats"
    attacked_player.gets_dammage(damage)
  end
  def to_s
    return "#{@name}"
  end
  def is_alive?
    @life_points > 0
  end
end



class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
    super(name)
    @life_points = 100
    @weapon_level = 1
  end
  def compute_damage
    rand(1..6)*@weapon_level
  end

  def search_weapon
    random = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{random}".italic.magenta
    if random > @weapon_level
      puts "⚔️  ⚔️  ⚔️  Youhou ! elle est meilleure que ton arme actuelle : tu la prends !⚔️  ⚔️  ⚔️  ".bold.green
      @weapon_level = random
    else
      puts "M@*#$... elle n'est pas mieux que ton arme actuelle...".bold.red
    end
  end

  def search_health_pack
    random = rand(1..6)
    case random
    when 1
      puts "Tu n'as rien trouvé...".bold.red
    when 2..5
      puts "💉  💉  💉  Bravo, tu as trouvé un pack de +50 points de vie !💉  💉  💉".bold.green
      @life_points += 50
      @life_points = 100 if @life_points > 100
    when 6
      puts "💉  💉  💉  Waow, tu as trouvé un pack de +80 points de vie !💉  💉  💉".bold.green
      @life_points += 80
      @life_points = 100 if @life_points > 100
    end
  end

  def show_state #Surcharge de show_state pour avoir des couleurs qui vont bien ;)
    if @life_points < 20
      print "#{@name}".bold, " a ", "#{@life_points}".bold.red.blink, " points de vie."
    elsif @life_points < 35
      print "#{@name}".bold, " a ", "#{@life_points}".bold.red, " points de vie."
    else
      print "#{@name}".bold, " a ", "#{@life_points}".blue, " points de vie."
    end
    print "Il possède une arme niveau ", "#{@weapon_level}".bold.green,"\n"
  end
end
