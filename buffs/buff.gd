class_name Buff extends Resource

@export var show_active:bool
@export var active_pic:Texture2D

@export var target:Move.TARGETS
@export var stackable:bool
@export var stack_id:String

@export var til_death:bool

@export var harmful:bool
@export var friendly:bool
@export var control_buff:bool

var _owner:Character
var move:Move
var user:Character

func apply(character:Character,move:Move):
	pass

func remove():
	TargettingManager.remove_active_buff.emit(self)
	_owner.buffs.erase(self)
	
func alter_outgoing_damage(amt:int,m:Move,damage_type:DamageEffect.DAMAGES)->int:
	return amt

func alter_incoming_damage(amt:int,m:Move,damage_type:DamageEffect.DAMAGES)->int:
	return amt

func stack():
	pass
	
func on_start_turn():
	pass
	
func on_end_turn():
	pass

func get_message():
	return ""
	
func attacked(standee:AttackStandee):
	return true

func on_ally_death(c:Character):
	pass
	
func on_user_stun(c:Character,s:Stun):
	if user==c:
		if move.classes.has(Move.CLASSES.Controlling) or move.classes.has(Move.CLASSES.Action):
			if s.classes.is_empty():
				remove()
			else:
				if s.classes.any(func(x):x in move.classes):
					remove()

func on_skill_use(standee:AttackStandee):
	return true

func get_altered(effect:Effect):
	pass
