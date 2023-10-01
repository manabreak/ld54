extends StaticBody2D

@export
var game_controller: Node2D

@export
var player: Node2D

@export
var door_sound: AudioStreamPlayer

func _on_unlocker_body_entered(body):
	print("Body entered door unlocker")
	if body == player:
		print("Player entered the door unlock area")
		if game_controller.key_count > 0:
			print("Player opened door!")
			open_door()

func open_door():
	var lock = $Lock
	door_sound.play()
	queue_free()
