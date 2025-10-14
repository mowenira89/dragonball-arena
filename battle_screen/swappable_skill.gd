class_name SwappableSkill extends TextureRect
@onready var color_rect: ColorRect = $ColorRect

var index:int
var move:Move

func _ready():
	TargettingManager.reset_swappables.connect(unselect)

func create(m:Move,i:int):
	move=m
	index=i
	texture=move.pic
	

func select():
	color_rect.visible=true
	
func unselect():
	color_rect.visible=false
	


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_released("Click"):
		if TargettingManager.first_index==-1:
			TargettingManager.set_first_index(index)
		else:
			TargettingManager.swap(index)
			TargettingManager.reset_swappables.emit()
		
