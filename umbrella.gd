extends Node2D

const SPEED = 2.0

@export
var player: Node2D

var controls_enabled = false

func enable_controls():
	controls_enabled = true

func disable_controls():
	controls_enabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if controls_enabled:
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
