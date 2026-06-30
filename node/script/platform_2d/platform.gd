extends CharacterBody2D

#------------------variable-------------------------
@export var SPEED = 300.0
@export var JUMP_VELOCITY = 400.0

#-----------------variable(hide)--------------------
var double_jump = false
var animation : AnimatedSprite2D


func _ready() -> void:
	for child in get_children():
		if child is AnimatedSprite2D:
			animation = child

func _physics_process(delta: float) -> void:
	movement(delta)

func movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y  = - JUMP_VELOCITY
			double_jump = true
		elif double_jump:
			velocity.y = - JUMP_VELOCITY
			double_jump = false
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction > 0:
		velocity.x = direction * SPEED
		animation.play("turn")
		animation.flip_h = false
	elif direction < 0:
		velocity.x = direction * SPEED
		animation.play("turn")
		animation.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation.animation = "idle"
		
	move_and_slide()
