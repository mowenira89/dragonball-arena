class_name AlterOutgoingDamageBuff extends TimedBuff

@export var amount:int 

@export var classes:Array[Move.CLASSES]

func alter_outgoing_damage(amt:int,m:Move,damage_type:DamageEffect.DAMAGES):
	if !classes.is_empty():
		if m.classes.any(check_class):
			return amt+amount
	return amt+amount

func check_class(c:int):
	if classes.has(c):
		return true

func get_message():
	if !classes.is_empty():
		var dmg_type = []
		for x in classes: 
			dmg_type.append(Move.CLASSES.keys()[x])
		var class_str = ""
		for x in dmg_type:
			class_str+=dmg_type+", "
		class_str.left(class_str.length()-2)
		var sentence = "Altering outgoing {0} damage by {1}".format([class_str,amount])
		return sentence
	else:
		return "Altering outgoing damage by {0}".format([amount])
