class Monster
  attr_accessor :name, :attack, :armor, :hp

  def initialize(name, attack, armor, hp)
    @name   = name
    @attack = attack
    @armor  = armor
    @hp     = hp
  end
end