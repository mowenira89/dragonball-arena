class_name ApplyBuff extends Effect

@export var buff:Buff

func apply(standee,t:Character):
	var targets = TargettingManager.buff_targetting(standee,buff)
	for x in targets:
		if x.buffs.any(func(b):b is NoBlock) and buff is Invulnerable:
			return false
		var new_buff=buff.duplicate()
		new_buff._owner=x
		new_buff.move=standee.move
		standee.target.add_buff(new_buff,standee.move,standee.user)

func add_active_buff():
	TargettingManager.attach_active_buff.emit(buff)
