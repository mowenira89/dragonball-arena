class_name AlterMove extends Effect

@export var move_to_alter:Move

@export var change_damage:int
@export var change_type:DamageEffect.DAMAGES
@export var do_change_type:bool
@export var new_cost:Dictionary[Move.ENERGIES,int]
@export var new_random_energy:int=-1
@export var new_unrandom_energy:Dictionary[Move.ENERGIES,int]
@export var alter_counterability:bool

@export var revert:int

func apply(standee:AttackStandee,t:Character):
	var move:Move
	var original_move
	
	original_move=move
	var damage_effect:DamageEffect
	for x in standee.user.moves:
		if !move_to_alter:
			move_to_alter=standee.move
		if x.move_name==move_to_alter.move_name:
			move=x
			original_move=x
	if change_damage!=0:
		for x in move.effects:
			if x is DamageEffect:
				damage_effect=x
				break
		if damage_effect!=null:
			damage_effect.amount+=change_damage
	if do_change_type:
		for x in move.effects:
			if x is DamageEffect:
				damage_effect=x
				break
		if damage_effect!=null:
			damage_effect.damage_type=change_type
	if !new_cost.is_empty():
		move.cost=new_cost
	if new_random_energy!=-1:
		move.random_energy=new_random_energy
	if !new_unrandom_energy.is_empty():
		move.unrandom_energy=new_unrandom_energy
	if alter_counterability:
		move.uncounterable=!move.uncounterable
		
	if revert>0:
		var new_alter_move:AlterMove=AlterMove.new()
		var new_time_event:TimedEvent=TimedEvent.new()
		
		
		
		if change_damage!=0:
			if damage_effect!=null:
				var new_damage=change_damage*-1
				new_alter_move.change_damage=new_damage
		if do_change_type:
			if damage_effect!=null:
				var original_damage:DamageEffect=original_move.get_damage()
				if original_damage:
					new_alter_move.change_type=original_damage.damage_type
					new_alter_move.do_change_type=true
		if !new_cost.is_empty():
			new_alter_move.new_cost=original_move.cost
		if new_random_energy!=-1:
			new_alter_move.new_random_energy=original_move.random_energy
		if !new_unrandom_energy.is_empty():
			new_alter_move.unrandom_energy=original_move.unrandom_energy
		if alter_counterability:
			new_alter_move.alter_counterability=original_move.uncounterable
			
		new_time_event.event=new_alter_move
		new_time_event.turns=1
		t.add_buff(new_time_event,standee.move,standee.user)		
			
		
			
