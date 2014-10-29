class Monster
  attr_accessor :name, :attack, :armor, :hp, :residual_hp

  def initialize(name, attack, armor, hp)
    @name   = name
    @attack = attack
    @armor  = armor
    @hp     = hp
    @residual_hp = @hp
  end
end
