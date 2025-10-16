class_name SelectionScreen extends Control
@onready var username: Label = $MarginContainer/CharacterSelectionVBox/UserPanel/VBoxContainer/Username
@onready var user_stats: Label = $MarginContainer/CharacterSelectionVBox/UserPanel/VBoxContainer/UserStats
@onready var profile_pic: Sprite2D = $MarginContainer/CharacterSelectionVBox/UserPanel/ProfilePic
@onready var characters_container: GridContainer = $MarginContainer/CharacterSelectionVBox/CharacterPanel/MarginContainer/VBoxContainer/CharactersContainer
@onready var skill_container: MarginContainer = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer
@onready var character_name: Label = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/CharacterName
@onready var face_pic: TextureRect = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/HBoxContainer/FacePic
@onready var move_icons: HBoxContainer = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/HBoxContainer/MoveIcons
@onready var move_name: Label = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/HBoxContainer2/MoveName
@onready var energy_container: HBoxContainer = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/HBoxContainer2/EnergyContainer
@onready var classes: Label = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/HBoxContainer3/Classes
@onready var cooldown: Label = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/HBoxContainer3/Cooldown
@onready var description: RichTextLabel = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/Description
@onready var cost: Label = $MarginContainer/CharacterSelectionVBox/CharacterSkillPanel/SkillContainer/VBoxContainer/HBoxContainer2/Cost
@onready var box_1: CharacterChoiceBox = $MarginContainer/CharacterSelectionVBox/UserPanel/box1
@onready var box_2: CharacterChoiceBox = $MarginContainer/CharacterSelectionVBox/UserPanel/box2
@onready var box_3: CharacterChoiceBox = $MarginContainer/CharacterSelectionVBox/UserPanel/box3


const char_selector = preload("res://selection_screen/character_select_box.tscn")

const move_icon = preload("res://selection_screen/move_icon.tscn")
const battle_screen = preload("res://battle_screen/battle_screen.tscn")

var selected_character:Character



func _ready():
	set_profile()
	set_chars()
	box_1.send_box.connect(choose_character)
	box_2.send_box.connect(choose_character)
	box_3.send_box.connect(choose_character)
	
func set_profile():
	if !ProfileManager.profile:
		ProfileManager.profile=load("res://profiles/demo.tres")
	var prof = ProfileManager.profile
	username.text = prof.name
	var stats = "Level: {0}\nRank: {1}\nRatio: {2}:{3}({4})\nClan: {5}".format([prof.level,prof.rank,prof.wins,prof.loses,prof.current_streak,prof.clan])
	user_stats.text=stats
	profile_pic.texture=prof.profile_pic
	profile_pic.visible=true
	
func set_chars():
	for x in characters_container.get_children():
		x.queue_free()
	var prof = ProfileManager.profile
	for x in prof.characters:
		if prof.characters[x]==1:
			var new_char = char_selector.instantiate()
			characters_container.add_child(new_char)
			var char = load("res://characters/{0}.tres".format([x]))
			new_char.create_selector(char)
			new_char.char_selected.connect(set_moves_box)
			
func set_moves_box(character:Character):
	reset_move_box()
	selected_character=character
	skill_container.visible=true
	face_pic.texture=character.pic
	character_name.text=character.name
	for x in move_icons.get_children():
		x.queue_free()
	for x in character.moves:
		var new_icon = move_icon.instantiate()
		move_icons.add_child(new_icon)
		new_icon.send_move.connect(show_move)
		new_icon.create_icon(x)
		
	
func show_move(move:Move):
	move_name.text=move.move_name
	for x in energy_container.get_children():
		x.queue_free()
	for x in move.cost:
		for y in move.cost[x]:		
			var new_square = TextureRect.new()
			energy_container.add_child(new_square)
			var im = load("res://images/Energy/{0} energy.png".format([Move.ENERGIES.keys()[x].to_lower()]))
			new_square.texture=im
	var classes_string:String = "Classes: "
	for x in move.classes:
		classes_string+=Move.CLASSES.keys()[x]
		classes_string+=","
	classes_string=classes_string.left(classes_string.length()-1)
	classes.text = classes_string
	cooldown.text = "Cooldown: " + str(move.cooldown)
	description.text = move.description
	cost.text = "Energy Cost: "

func reset_move_box():
	cost.text=""
	description.text=""
	classes.text=""
	for x in energy_container.get_children():
		x.queue_free()
	move_name.text=""
	cooldown.text=""

func choose_character(box:CharacterChoiceBox):
	box.set_box(selected_character)


func _on_quick_game_button_pressed() -> void:
	if box_1.character!=null and box_2.character!=null and box_3.character!=null:
		var l:Array[Character] = [box_1.character.duplicate(),box_2.character.duplicate(),box_3.character.duplicate()]
		TargettingManager.friendlies=l
		for x in TargettingManager.friendlies:
			for y in x.moves:
				y.character=x
		get_random_enemies()
		var new_battle = battle_screen.instantiate()
		$".".add_child(new_battle)
		

		
func get_random_enemies():
	
	var dir=ResourceLoader.list_directory("res://characters/")
	var potential_enemies = []
	for x in dir:
		if x!="character.gd":
			potential_enemies.append(x)
	var path = "res://characters/"
	var opponents:Array[Character] = []
	for x in 3:
		var p = path+potential_enemies.pick_random()
		opponents.append(load(p).duplicate())
	TargettingManager.opponents=opponents
	for x in TargettingManager.opponents:
		for y in x.moves:
			y.character=x
	
