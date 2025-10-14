class_name Opponent extends Control
@onready var character_pic: CharacterPic = $HBoxContainer/CharacterPic

@onready var active_effects: GridContainer = $HBoxContainer/ActiveEffects

const ACTIVE_BUFF = preload("res://battle_screen/active_buff.tscn")

var character:Character

func _ready():
	TargettingManager.attach_active_moves.connect(attach_active_move)
	TargettingManager.attach_active_buff.connect(attach_active_buff)

func set_opponent(c:Character):
	character=c
	character_pic.character=c
	character_pic.pic.texture=c.pic

func flash_pic():
	character_pic.flash_pic()
	
	
func untarget():
	character_pic.untarget()
	
func target():
	character_pic.target()


func attach_active_move(c:Character,attachment:ActiveMove):
	if character_pic.character==c and c.current_hp>0:
		active_effects.add_child(attachment)
		
func attach_active_buff(c:Character,b:Buff):
	if character==c and c.current_hp>0:
		var new_ab = ACTIVE_BUFF.instantiate()
		new_ab.create(b.move,b)
		active_effects.add_child(new_ab)


	
		
