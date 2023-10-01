extends Area2D

const SPEED = 32.0

@export
var walk_distance = 128.0

@onready
var start_x = position.x

@export
var player: Node2D

var walking_right = true
var flip_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if flip_timer > 0.0:
		flip_timer -= delta
	
	if walking_right:
		position.x += SPEED * delta
		if position.x - start_x >= walk_distance:
			walking_right = false
			$AnimatedSprite2D.flip_h = true
	else:
		position.x -= SPEED * delta
		if position.x - start_x <= 0.0:
			walking_right = true
			$AnimatedSprite2D.flip_h = false


func _on_area_entered(area):
	print("Thimble: area entered: " + str(area))


func _on_body_entered(body):
	if body == player:
		print("Thimble hit player!")
		player.kill()
	if body.collision_layer & 8 >= 1 and flip_timer <= 0.0:
		walking_right = not walking_right
		$AnimatedSprite2D.flip_h = not walking_right
		flip_timer = 0.3


func _on_body_exited(body):
	if body.collision_layer & 8 >= 1 and flip_timer <= 0.0:
		walking_right = not walking_right
		$AnimatedSprite2D.flip_h = not walking_right
		flip_timer = 0.3
