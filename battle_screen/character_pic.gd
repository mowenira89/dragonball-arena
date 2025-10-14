class_name CharacterPic extends Control

@onready var pic: TextureRect = $Pic
@onready var overlay: ColorRect = $Pic/Overlay
@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var progress_bar: ProgressBar = $Pic/ProgressBar
@onready var dead: TextureRect = $Pic/Dead

signal move_used

var character:Character

func _ready():
	overlay.visible=false
	TargettingManager.untarget.connect(untarget)
	BattleManager.death.connect(death)

func _process(delta: float) -> void:
	progress_bar.value=character.current_hp

func flash_pic():
	anim.play("blink")
	
func untarget():
	anim.stop()
	overlay.visible=false
	
func target():
	overlay.visible=true


func _on_overlay_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		TargettingManager.target_selected.emit(character)
		EnergyManager.deduct_energy()
		move_used.emit(character)
		TargettingManager.untarget.emit()

func death(c:Character):
	if c==character:
		dead.visible=true
