extends Area2D

@export
var game_controller: Node2D

@export
var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body == player:
		print("Player collected a button!")
		game_controller.collect_button()
		queue_free()
