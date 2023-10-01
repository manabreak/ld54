extends Node

@onready
var intro = $Intro

@onready
var loop = $Loop


func _ready():
	intro.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_intro_finished():
	loop.play()


func _on_loop_finished():
	loop.play()
