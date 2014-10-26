puts "Welcome to Monster"
puts "version 0.0.1"

# link external file
load 'monster.rb'
load 'player.rb'



def fight(hero, monster)
  hero.hp    -= monster.attack - hero.armor
  puts "Hero fight monster for " + (monster.attack - hero.armor).to_s + "HP"
  monster.hp -= hero.attack - monster.armor
  puts "Monster fight Hero for " + (hero.attack - monster.armor).to_s + "HP"
  sleep(1)
end

def main_loop
  one_monster = Monster.new("Big Dog", 10, 1, 100)
  hero = Player.new("Hero", 11, 2, 90)
  
  loop do
    if one_monster.hp <= 0
      puts "YOU WIN!"
      return 0
    elsif hero.hp <= 0
      puts "Your Hero is dead!"
      return 0
    end
    fight(hero, one_monster)
    puts "Status:"
    puts "Hero:\t - " + hero.hp.to_s
    puts "Monster:\t - " + one_monster.hp.to_s
  end
end

main_loop()