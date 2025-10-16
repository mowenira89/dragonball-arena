class_name Character extends Resource

@export var pic:Texture2D
@export var name:String
@export var moves:Array[Move]
@export_multiline var desc:String
@export var setup_buffs:Array[Buff]
var battle_moves:Array[Move]
var current_hp:int=100

var buffs:Array[Buff]

func add_buff(buff:Buff,move:Move,u:Character):
	if current_hp>0:
		var new_buff = buff.duplicate()
		if !new_buff.stackable:
			for x in buffs:
				if new_buff.stack_id==x.stack_id:
					return false	
			register_buff(new_buff,move,u)
		else:
			for x in buffs:
				if x.stack_id==new_buff.stack_id:
					x.stack()
					return true
			register_buff(buff,move,u)
				
func register_buff(b:Buff,move:Move,u:Character):
	b._owner=self
	b.move=move
	b.user=u
	buffs.append(b)
	b.apply(self,move)
	if b.show_active or buffs.any(func(b):return b is ForceVisible):
		TargettingManager.attach_active_buff.emit(self,b)	

func setup():
	for x in setup_buffs:
		add_buff(x,null,self)
	
func heal(amount:int):
	current_hp+=amount

func take_damage(amount,damage_type,move):
	if buffs.any(func(b):b is ImmuneToDamage):
		return false
	var dmg=amount
	for x in buffs:
		dmg=x.alter_incoming_damage(dmg,move,damage_type)
	current_hp-=dmg
	
	if buffs.any(func(b):return b is Unkillable):
		if current_hp<=0:
			current_hp=1
	
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
			
func check_stun(move_class:Array[Move.CLASSES]):
	for b in buffs:
		if b is Stun:
			if move_class.is_empty():
				return true
			else:
				if b.classes.any(func(a):a in move_class):
					return true
					

func get_move(n:String):
	for x in moves:
		if x.move_name==n:
			return x
	return false
