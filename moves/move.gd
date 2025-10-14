class_name Move extends Resource

enum CLASSES {Physical,Energy,Affliction,Mental,Melee,Ranged,Special,Instant,Action,Controlling}

enum ENERGIES {Green,Yellow,Blue,Purple,Black}

enum TARGETS {Self,Opponent,Opponents,AllOpponents,Ally,AllAllies,Friendlies,All}

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

func use_move(standee:AttackStandee):
	var targets = TargettingManager.get_target(standee)
	
	if !ignore_invulnerable:
		var remove = []
		for chara in targets:
			if chara.buffs.any(func(b):return b is Invulnerable):
				if chara.buffs.any(func(b):return b is NoBlock):
					pass
				else:
					remove.append(chara)
		remove.any(func(r):targets.erase(r))
			
	for x in targets:
		for b in x.buffs:
			b.attacked(standee)
		for y in effects:
			y.apply(standee)
	if cooldown>0:
		BattleManager.start_cooldown.emit(self)
	TargettingManager.remove_in_use.emit(character)
