class_name AlterIncomingDamageBuff extends TimedBuff

@export var amount:int 

@export var classes:Array[Move.CLASSES]

func alter_incoming_damage(amt:int,m:Move,damage_type:DamageEffect.DAMAGES):
	if amount<0 and _owner.buffs.any(func(b):return b is NoBlock):
		return amt
	if amount<0 and damage_type==DamageEffect.DAMAGES.Piercing:
		return amt
	if !classes.is_empty():
		if m.classes.any(check_class):
			return amt+amount
		else:
			return amt
	else:
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
			class_str+=x+", "
		class_str.left(class_str.length()-2)
		var sentence = "Altering incoming {0} damage by {1}".format([class_str,amount])
		return sentence
	else:
		return "Altering incoming damage by {0}".format([amount])
