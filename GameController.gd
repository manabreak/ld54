extends Node2D

var player_controlled = true

@export
var player: Node2D

@export
var umbrella: Node2D

@export
var camera: Camera2D

var camera_target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	camera_target = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("switch_controls"):
		player_controlled = not player_controlled
		
		if player_controlled:
			player.enable_controls()
			umbrella.disable_controls()
			camera_target = player
		else:
			player.disable_controls()
			umbrella.enable_controls()
			camera_target = umbrella

func _physics_process(delta):
	camera.position = camera.position.lerp(camera_target.position, delta * 10.0)
