class Player
  attr_accessor :name, :attack, :armor, :hp, :residual_hp,
                :exp, :exp_for_next_level, :level

  def initialize(name, attack, armor, hp)
    @name   = name
    @attack = attack
    @armor  = armor
    @hp     = hp
    @residual_hp = @hp

    @level = 1
    @exp = 0
    @exp_for_next_level = 20
  end

  def level_up
    @level += 1

    @hp += @level * 300
    @residual_hp = @hp

    @exp = 0
    @exp_for_next_level += @level * 10
  end
end
