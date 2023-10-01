extends Node2D

const SPEED = 2.0

@export
var player: CharacterBody2D

@export
var umbrella_glow: Sprite2D

@onready
var umbrella_glow_color = umbrella_glow.self_modulate

@export
var outside_color: Color

var controls_enabled = false
var player_on_umbrella = false

func enable_controls():
	controls_enabled = true
	if player_on_umbrella:
		umbrella_glow.self_modulate = Color(1.0, 0.5, 0.5, 0.7)
	else:
		umbrella_glow.self_modulate = umbrella_glow_color
	
	umbrella_glow.self_modulate.a = 0.7
	
	$EnemyBlocker.set_collision_layer_value(4, false)

func disable_controls():
	controls_enabled = false
	umbrella_glow.self_modulate = umbrella_glow_color
	
	$EnemyBlocker.set_collision_layer_value(4, true)

# Called when the node enters the scene tree for the first time.
func _ready():
	var color = outside_color
	$Left.size = Vector2(1000.0, 128.0)
	$Left.position = Vector2(-1000.0 - 64.0, -64.0)
	$Left.color = color
	$Right.size = Vector2(1000.0, 128.0)
	$Right.position = Vector2(64.0, -64.0)
	$Right.color = color
	$Bottom.size = Vector2(1000.0, 1000.0)
	$Bottom.position = Vector2(-500.0, 0.0 + 64.0)
	$Bottom.color = color
	$Top.size = Vector2(1000.0, 1000.0)
	$Top.position = Vector2(-500.0, -1000.0 - 64.0)
	$Top.color = color
	
	$Left.z_index = 5
	$Right.z_index = 5
	$Bottom.z_index = 5
	$Top.z_index = 5


func _physics_process(delta):
	if controls_enabled and not player_on_umbrella and player.is_on_floor():
		var direction_x = Input.get_axis("move_left", "move_right")
		var direction_y = Input.get_axis("move_up", "move_down")
		if direction_x:
			position.x += direction_x * SPEED
			
			var dx = position.x - player.position.x
			if abs(dx) > 48.0:
				if dx > 0.0:
					position.x = player.position.x + 48.0
				else:
					position.x = player.position.x - 48.0
		if direction_y:
			position.y += direction_y * SPEED
			
			var dy = position.y - player.position.y
			if abs(dy) > 48.0:
				if dy > 0.0:
					position.y = player.position.y + 48.0
				else:
					position.y = player.position.y - 48.0


func _on_move_detector_body_entered(body):
	if body == player:
		print("Body standing on the bottom edge; cannot move umbrella")
		player_on_umbrella = true
		# umbrella_glow.self_modulate = Color(1.0, 0.5, 0.5, umbrella_glow_color.a)


func _on_move_detector_body_exited(body):
	if body == player:
		print("Player moved out")
		player_on_umbrella = false
		# umbrella_glow.self_modulate = umbrella_glow_color
