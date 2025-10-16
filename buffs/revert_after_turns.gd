class_name RevertAfterTurns extends TimedBuff

var move_name

func apply(character:Character,move:Move):
	super(character,move)
	move_name=revert_move_name_dict[move.move_name]

func on_end_turn():
	super()
	if self not in _owner.buffs:
		BattleManager.swap_skills.emit(_owner,move_name,)

const revert_move_name_dict = {
	"Energy Scan":"Energy Absorb"
}

const revert_dict = {
	"Energy Absorb":"res://moves/mr_popo/energy_scan.tres"
}
