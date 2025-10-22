class_name Move extends Resource

enum CLASSES {Physical,Energy,Affliction,Mental,Melee,Ranged,Special,Instant,Action,Controlling}

enum ENERGIES {Green,Yellow,Blue,Purple,Black,Random}

enum TARGETS {Self,Opponent,Opponents,AllOpponents,Ally,AllAllies,Friendlies,All,Random,AnyAlly}

var character:Character

@export var pic:Texture2D
@export var move_name:String
@export_multiline var description:String
@export var classes:Array[CLASSES]
@export var cost:Dictionary[ENERGIES,int]
@export var cooldown:int
@export var target:TARGETS
@export var effects:Array[Effect]
@export var ignore_invulnerable:bool
@export var needs_mark:bool
@export var stackable_boost:bool
@export var random_energy:int
@export var unrandom_energy:Dictionary[ENERGIES,int]
@export var uncounterable:bool
@export var attack:bool

func use_move(standee:AttackStandee):
	var targets = TargettingManager.get_target(standee)
	if !ignore_invulnerable:
		var remove = []
		for chara in targets:
			if chara.buffs.any(func(b):b is Invulnerable):
				if chara.buffs.any(func(b):return b is NoBlock):
					pass
				else:
					remove.append(chara)
		for x in remove:
			targets.erase(x)
	var used:bool
	for x in standee.user.buffs:
		used=x.on_skill_use(standee)
		if !used: 
			return false
	for x in targets:
		var proceed = true
		
		if attack:
			for b in x.buffs:
				var r = b.attacked(standee)
		
		for y in effects:
			if !y.conditions.is_empty():
				if !y.check_condition(standee):
					proceed=false
			if y is not DamageEffect and y.harmful and x.buffs.any(func(b):b is NoHarm):
				proceed=false
			
						
						
			if proceed:		
				y.apply(standee,x)
	if cooldown>0:
		BattleManager.start_cooldown.emit(self)
	TargettingManager.remove_in_use.emit(character)
	
func randomize_cost():
	cost.clear()
	for x in unrandom_energy:
		cost[x]=unrandom_energy[x]
	for x in random_energy:
		var i = randi_range(0,4)
		cost[x]=1
			
func get_damage():
	var damage:DamageEffect
	for x in effects:
		if x is DamageEffect:
			damage=x
			return damage
	return false
