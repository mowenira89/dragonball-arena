class_name SwapEffect extends Effect

@export var swap_to:Move
@export var move_to_swap:Move

func apply(standee:AttackStandee,t:Character):
	if !move_to_swap:
		move_to_swap=standee.move
	BattleManager.swap_skills.emit(standee.user,move_to_swap.move_name,swap_to.duplicate())
