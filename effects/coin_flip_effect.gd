class_name CoinFlipEffect extends Effect

@export var effect_1:Effect
@export var effect_2:Effect

func apply(standee:AttackStandee,target:Character):
	var flip = randi_range(0,100)
	if flip>50:
		effect_1.apply(standee,target)
	else:
		effect_2.apply(standee,target)
