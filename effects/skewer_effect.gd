class_name SkewerEffect extends Effect

@export var move_name:String
@export var effect:Effect

func apply(standee,t:Character):
	for b in t.buffs:
		if b is Stun and b.move.move_name==move_name:
			effect.apply(standee,t)
