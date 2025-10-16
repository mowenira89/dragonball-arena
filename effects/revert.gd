class_name RevertEffect extends Effect

func apply(standee,t:Character):
	var new_move = load(revert_dict[standee.move.move_name]).duplicate()
	BattleManager.swap_skills.emit(standee.user,standee.move.move_name,new_move)

const revert_dict = {
	"City Bomb":"res://moves/demon_king/preparations.tres",
	"Sky Kick":"res://moves/grandpa_gohan/throw.tres"
}
