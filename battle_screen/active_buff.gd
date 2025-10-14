class_name ActiveBuff extends TextureRect

const skill_view_window = preload("res://battle_screen/active_buff_tooltip.tscn")

var move:Move
var buff:Buff

var current_skill_view:ActiveBuffTooltip

func _ready():
	BattleManager.death.connect(remove_on_death)
	TargettingManager.remove_active_buff.connect(remove)


func remove_on_death(c:Character):
	if buff.til_death and buff.user==c:
		buff.remove()
		remove(buff)
	

func create(m:Move,b:Buff):
	move=m
	buff=b
	if buff.active_pic!=null:
		texture=buff.active_pic
	else:
		texture=m.pic
	
	
func remove(b:Buff):
	if b==buff:
		queue_free()

func show_skill_info():
	var view = skill_view_window.instantiate()
	$".".add_child(view)
	view.global_position=get_global_mouse_position()
	view.create_panel(move,buff)
	current_skill_view=view

func _on_mouse_entered() -> void:
	show_skill_info()

func _on_mouse_exited() -> void:
	current_skill_view.queue_free()
