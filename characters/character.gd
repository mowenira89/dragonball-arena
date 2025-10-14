class_name Character extends Resource

@export var pic:Texture2D
@export var name:String
@export var moves:Array[Move]
@export_multiline var desc:String

var current_hp:int=100

var buffs:Array[Buff]

func add_buff(buff:Buff,move:Move,u:Character):
	if current_hp>0:
		var new_buff = buff.duplicate()
		if !new_buff.stackable:
			for x in buffs:
				if new_buff.stack_id==x.stack_id:
					return false	
			new_buff._owner=self
			new_buff.move=move
			new_buff.user=u
			buffs.append(new_buff)
			new_buff.apply(self,move)
			if new_buff.show_active:
				TargettingManager.attach_active_buff.emit(self,new_buff)
			return true
		else:
			for x in buffs:
				if x.stack_id==new_buff.stack_id:
					x.stack()
	return false
	
	
func take_damage(amount,damage_type,move):
	var dmg=amount
	for x in buffs:
		dmg=x.alter_incoming_damage(dmg,move,damage_type)
	current_hp-=dmg
	if current_hp<=0:
		BattleManager.death.emit(self)
		if TargettingManager.friendlies.any(func(c):c.current_hp>0):
			pass
		else:
			BattleManager.gameover.emit("Lose")
			return
		if TargettingManager.opponents.any(func(c):c.current_hp>0):
			pass
		else:
			BattleManager.gameover.emit("Win")
		

func move_opponent():
	if randi()%101>2:
		
		var new_move:Move=moves.pick_random()
		var target
		if buffs.any(func(b):return b is Stun):
			return
		if buffs.any(func(b):return b is AOE) and new_move.target==Move.TARGETS.Opponent:
			target = TargettingManager.friendlies
		match new_move.target:
			Move.TARGETS.Self:
				target= self
			Move.TARGETS.AllOpponents:
				target= TargettingManager.friendlies.pick_random()
			Move.TARGETS.Ally:
				target=self
				while target==self:
					target=TargettingManager.opponents.pick_random()
			Move.TARGETS.Friendlies:
				target=TargettingManager.opponents.pick_random()
			Move.TARGETS.Opponent:
				target = TargettingManager.friendlies.pick_random()
		
		var standee = AttackStandee.new()
		standee.create_standee(self,target,new_move)
		TargettingManager.attack_queue.append(standee)
			
