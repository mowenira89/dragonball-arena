class_name Heal extends Effect

@export var amount:int

func apply(standee:AttackStandee,t:Character):
	t.heal(amount)
