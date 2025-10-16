class_name SkillPanel extends Control
@onready var skills_container: HBoxContainer = $TextureRect/SkillContainer

const skill_button = preload("res://battle_screen/battle_skill_button.tscn")

const skill_view_window = preload("res://battle_screen/skill_view_panel.tscn")

const active_buff = preload("res://battle_screen/active_buff.tscn")

@onready var character_pic: CharacterPic = $CharacterPic

var button_group:ButtonGroup

var character:Character

var current_skill_view:SkillViewPanel

@onready var active_skills: HBoxContainer = $ActiveSkills

func _ready():
	TargettingManager.character_moved.connect(move_selected)
	TargettingManager.target_selected.connect(set_in_use)
	TargettingManager.attach_active_moves.connect(attach_active_move)
	TargettingManager.attach_active_buff.connect(attach_active_buff)
	TargettingManager.remove_in_use.connect(remove_in_use)
	BattleManager.death.connect(death)
	BattleManager.stun.connect(stun)
	BattleManager.unstun.connect(unstun)
	BattleManager.swap_skills.connect(swap_skills)
	BattleManager.start_turn.connect(start_turn)

func create_panel(char:Character):
	character=char
	populate_skills()
	character_pic.pic.texture=char.pic
	character_pic.character=char
	character.setup()
	

func populate_skills():
	for x in character.moves:
		var new_button = skill_button.instantiate()
		skills_container.add_child(new_button)
		new_button.create_button(x,character)
		new_button.send_move_data.connect(show_skill_info)
		new_button.destroy_skill_view.connect(destroy_skill_view)
		new_button.unselect.connect(move_unselected)
		
func show_skill_info(move:Move):
	var view = skill_view_window.instantiate()
	$".".add_child(view)
	view.global_position=get_global_mouse_position()
	view.create_panel(move)
	current_skill_view=view
		
func destroy_skill_view():
	current_skill_view.queue_free()

func flash_pic():
	character_pic.flash_pic()
	
func untarget():
	character_pic.untarget()
	
func target():
	character_pic.target()

func move_selected():
	if character==TargettingManager.currently_targetting:
		for x in skills_container.get_children():
			x.active=false
			
func set_in_use(c:Character):
	for x in skills_container.get_children():
		if x.move==TargettingManager.current_move:
			x.in_use.visible=true
		

func move_unselected(char:Character):
	if char==character:
		for x in skills_container.get_children():
			x.in_use.visible=false
			x.active=true
		for x in TargettingManager.attack_queue:
			if x.user==char:
				TargettingManager.attack_queue.erase(x)
	
func remove_in_use(c:Character):
	if character==c:
		for x in skills_container.get_children():
			x.in_use.visible=false
			x.active=true

func attach_active_move(c:Character,attachment:ActiveMove):
	if character==c and character.current_hp>0:
		active_skills.add_child(attachment)
		
func attach_active_buff(c:Character, buff:Buff):
	if c==character and character.current_hp>0:
		var attachment = active_buff.instantiate()
		attachment.create(buff.move,buff)
		active_skills.add_child(attachment)

func death(c:Character):
	if character==c:
		for x in skills_container.get_children():
			x.active=false

func stun(b:Stun):
	if b._owner==character:
		if !b.classes.is_empty():
			for x in skills_container:
				for y in x.move.classes:
					if y.any(func(a):return b.classes.has(a)):
						x.stun.visible=true
		else:
			for x in skills_container:
				x.stun.visible=true
				
func unstun(b:Stun):
	if b._owner==character:
		if !b.classes.is_empty():
			for x in skills_container:
				for y in x.move.classes:
					if y.any(func(a):return b.classes.has(a)):
						x.stun.visible=false
		else:
			for x in skills_container:
				x.stun.visible=false				
				
func swap_skills(c:Character,move_name:String,new_move:Move):
	if character==c:
		for x in skills_container.get_children():
			if x.move.move_name==move_name:
				x.character.battle_moves.erase(x.move)
				x.create_button(new_move,c)

	
func start_turn():
	for x in skills_container.get_children():
		if x.move.random_energy>0:
			x.move.randomize_cost()

	
