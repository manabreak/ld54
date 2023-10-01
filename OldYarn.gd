extends Area2D

@export
var player: Node2D

@export
var game_controller: Node2D

@export
var label: Label

@export
var level: int

var story_counter = 0

var level_1_messages := [
	"Phew! It's not just raining, it's pouring!\n(Press SPACE)",
	"This rain... It's caused by the toxic\nfumes from the factory.",
	"I want you to go and shut it down!",
	"To do that, we need buttons.\nLots of them.",
	"Now, I know we are just balls of yarn...",
	"...and we can't get wet.",
	"But wait! I've devised this, err,\ndevice.",
	"This keeps the rain away!",
	"Think of it as a magic umbrella.",
	"Press TAB to move it around with arrow keys.\n(Or WASD keys.)",
	"Press TAB again when you're done moving it.",
	"(You can move around with arrow keys or WASD keys too!)",
	"However... It has downsides.",
	"You can't move while you move it...",
	"You can't move it around if you're standing on it...",
	"...and everything gets trapped in it.",
	"If you get stuck, press R to jump back here.",
	"Well, good luck!",
	"Oh, almost forgot:\nFirst, I need 10 buttons.",
	"Go gather them!"
]

var level_2_messages := [
	"Okay, I need 10 more buttons.",
	"Be careful! I think we have company!"
]

var current_msg_index = 0
var speaking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Tail.play("default")
	$Body.play("default")
	$Eyes.play("default")
	
	player.disable_controls()
	
	if level == 1:
		do_level1_speech()
	elif level == 2:
		do_level2_speech()


func do_level1_speech():
	print("Level 1 speech starting")
	speaking = true
	current_msg_index = 0
	show_message(get_message())

func do_level2_speech():
	print("Level 2 speech starting")
	speaking = true
	current_msg_index = 0
	show_message(get_message())

func get_msg_count():
	match level:
		1: return len(level_1_messages)
		2: return len(level_2_messages)

func get_message():
	match level:
		1: return level_1_messages[current_msg_index]
		2: return level_2_messages[current_msg_index]

func show_message(msg):
	print("Show messsage: " + msg)
	label.text = msg
	var tween = get_tree().create_tween()
	tween.tween_property(label, "self_modulate", Color.WHITE, 0.3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if speaking:
		if Input.is_action_just_pressed("jump"):
			current_msg_index += 1
			if current_msg_index >= get_msg_count():
				speaking = false
				player.enable_controls()
			else:
				$ChatterShort.play()
				show_message(get_message())
				


func _on_body_entered(body):
	if body == player and not speaking:
		var button_count = game_controller.button_count
		if button_count == 0:
			show_message("There are 10 buttons out there somewhere.\nCould you gather them for me?")
		elif button_count < 10:
			show_message("I still need " + str(10 - button_count) + " more buttons.")
		else:
			if level == 2:
				show_message("Good job! You found all the buttons!\nThanks for playing!")
			else:
				show_message("Good job! You found all the buttons!")
			
			player.disable_controls()
			$LevelChangeTimer.start()


func _on_body_exited(body):
	if body == player and not speaking:
		var tween = get_tree().create_tween()
		tween.tween_property(label, "self_modulate", Color.TRANSPARENT, 0.3)
