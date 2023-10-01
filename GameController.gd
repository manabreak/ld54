extends Node2D

var player_controlled = true

@export
var player: Node2D

@export
var umbrella: Node2D

@export
var camera: Camera2D

@export
var old_yarn: Node2D

@export
var level: int

@export
var fader: ColorRect

var camera_target: Node2D

var key_count = 0
var button_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_target = umbrella
	fader.color = Color.BLACK
	var tween = get_tree().create_tween()
	tween.tween_property(fader, "color", Color(0, 0, 0, 0), 2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("switch_controls") and not old_yarn.speaking:
		player_controlled = not player_controlled
		
		if player_controlled:
			player.enable_controls()
			umbrella.disable_controls()
			camera_target = umbrella
		else:
			player.disable_controls()
			umbrella.enable_controls()
			camera_target = umbrella

func _physics_process(delta):
	camera.position = camera.position.lerp(camera_target.position, delta * 10.0)


func _on_key_body_entered(body):
	if body == player:
		print("Player picked up a key!")
		key_count += 1
		


func _on_unlocker_body_entered(body):
	if body == player and key_count > 0:
		print("Player opened a door!")
		key_count -= 1

func collect_button():
	button_count += 1
	$ButtonSound.play()


func _on_spikes_body_entered(body):
	if body == player:
		print("Player hit spikes!")
		player.kill()

func fadeout_done():
	if level == 1:
		print("Level changing!")
		get_tree().change_scene_to_file("res://level_0002.tscn")
	else:
		print("Game done, fading out...")

func _on_level_change_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(fader, "color", Color.BLACK, 2.0)
	tween.tween_callback(self.fadeout_done)
	
	
