#!/usr/bin/env ruby

require 'curses'
include Curses

# link external file
load 'monster.rb'
load 'player.rb'
#load 'gui.rb'

def show_message(message)
  width = message.length + 10
  win = Window.new(7, width,
                   0, 0)
  #win.box(?|, ?-)
  win.setpos(0, 0)
  win.addstr(message)
  win.refresh
  win.close
end

def fight_message(message)
  width = message.length + 10
  win = Window.new(5, width,
                   10, 0)
  #win.box(?|, ?-)
  win.setpos(10, 10)
  win.addstr(message)
  win.refresh
  win.close
end

def graph_hp(residual_hp, full_hp)
  residual_hp_string = ''

  full_hp_length = 40
  length = residual_hp.to_f / full_hp * full_hp_length
  length = length.to_i

  length.times do
    residual_hp_string += '|'
  end

  #return residual_hp_string + '(' + residual_hp.to_s + '/' + full_hp.to_s + ')'
  return residual_hp_string
end

def attack_with_ratio(attack)
  float_number = rand(0.6..1.4)
  final_attack = attack * float_number
  return final_attack.to_i
end

def fight(hero, monster)
  monster_attack = attack_with_ratio(monster.attack)
  hero.residual_hp -= (monster_attack - hero.armor)
  message = "Hero fight monster for " + monster_attack.to_s + "HP\n"

  hero_attack = attack_with_ratio(hero.attack)
  monster.residual_hp -= (hero_attack - monster.armor)
  message += "Monster fight Hero for " + hero_attack.to_s + "HP\n"

  fight_message message

  message = "[#{hero.name}] #{hero.residual_hp}/#{hero.hp} - #{hero.attack}/#{hero.armor}\n"
  message += "Level: #{hero.level}\n"
  message += "Exp: (#{hero.exp}/#{hero.exp_for_next_level})\n"
  message += "HP:\t " + graph_hp(hero.residual_hp, hero.hp) + "\n"

  message += "[#{monster.name}] #{monster.residual_hp}/#{monster.hp} - #{monster.attack}/#{monster.armor}\n"
  message += "HP:\t " + graph_hp(monster.residual_hp, monster.hp) + "\n"
  show_message message
end

def main_loop
  init_screen

  begin
    crmode
    refresh
    hero = Player.new("Shown Tien", 11, 2, 1000)
    one_monster = Monster.new("Big Dog", 10, 1, 100)

    monster_is_dead = false
    loop do
      if monster_is_dead
        one_monster = Monster.new("Leona Young", 10, 1, 100)
        monster_is_dead = false
      end

      refresh
      fight(hero, one_monster)

      # Player WIN
      if one_monster.residual_hp <= 0
        #show_message "YOU WIN!"
        monster_is_dead = true
        one_monster = nil
        hero.exp += 10
        sleep(1)

        # if LEVEL UP
        if hero.exp >= hero.exp_for_next_level
          hero.level_up
        end
      end

      # Player Dead
      if hero.residual_hp <= 0
        show_message "Your Hero is dead!"
        sleep(10)
        return 0
      end

      #getch
      sleep(0.1)
    end
  ensure
    close_screen
  end
end

main_loop()
