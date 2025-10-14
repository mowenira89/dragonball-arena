class_name ActiveMove extends TextureRect

const skill_view_window = preload("res://battle_screen/skill_view_panel.tscn")

var move:Move

var current_skill_view:SkillViewPanel

func _ready():
	TargettingManager.remove_active_moves.connect(remove)

func create():
	move = TargettingManager.current_move
	texture=move.pic

func remove(m:Move):
	if m==move:	
		queue_free()	

func show_skill_info():
	var view = skill_view_window.instantiate()
	$".".add_child(view)
	view.global_position=get_global_mouse_position()
	view.create_panel(move)
	current_skill_view=view

func _on_mouse_entered() -> void:
	show_skill_info()

func _on_mouse_exited() -> void:
	current_skill_view.queue_free()
