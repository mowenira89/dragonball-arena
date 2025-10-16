class_name LifeStealBuff extends TimedBuff

@export var amount:int

func apply(character:Character,move:Move):
	_owner.take_damage(amount,DamageEffect.DAMAGES.HealthSteal,move)
	user.heal(amount)

func on_start_turn():
	_owner.take_damage(amount,DamageEffect.DAMAGES.HealthSteal,move)
	user.heal(amount)
