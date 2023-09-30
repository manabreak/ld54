extends CharacterBody2D


const SPEED = 120.0
const JUMP_VELOCITY_INITIAL = -80.0
const JUMP_FORCE = -50.0
const JUMP_TIMER = 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var jump_timer = JUMP_TIMER
var jumping = false

var initial_position: Vector2

@export
var umbrella: Node2D

var controls_enabled = true

func enable_controls():
	controls_enabled = true

func disable_controls():
	controls_enabled = false

func _ready():
	initial_position = position
	$Body.play("Idle")
	$Eyes.play("default")
	$Tail.play("default")

func kill():
	position = initial_position
	umbrella.position = position

func start_jump():
	jump_timer = JUMP_TIMER
	jumping = true
	velocity.y = JUMP_VELOCITY_INITIAL

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("restart"):
		kill()

	# Handle Jump.
	if controls_enabled and Input.is_action_just_pressed("jump") and is_on_floor():
		start_jump()
	elif jumping and not Input.is_action_pressed("jump"):
		jumping = false
		
	if jumping and controls_enabled and Input.is_action_pressed("jump") and jump_timer > 0.0:
		velocity.y += JUMP_FORCE * jump_timer
		jump_timer -= delta
	
	if jump_timer <= 0.0:
		jumping = false
		
	#if Input.is_action_just_pressed("move_umbrella"):
	#	umbrella.position = self.position

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if controls_enabled and direction:
		velocity.x = direction * SPEED
		
		$Body.flip_h = direction < 0
		$Eyes.flip_h = direction < 0
		$Tail.flip_h = direction < 0
		if direction < 0:
			$Tail.position.x = 14
		else:
			$Tail.position.x = -14
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_damage_detector_area_entered(area):
	print("Area detected: " + str(area))


func _on_damage_detector_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("Area detected: " + str(area))
