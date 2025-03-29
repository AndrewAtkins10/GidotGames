extends CharacterBody2D

@onready var anim = $Sprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const GRAVITY = 980

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if is_on_floor():
		if direction:
			velocity.x = direction * SPEED
			anim.flip_h = direction < 0  # Flip sprite for left movement
			anim.play("walk")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED*delta)
			anim.play("idle")
	else:
		if velocity.y > 0:
			anim.play("jump")  # Can differentiate "jump" and "fall" if needed

	move_and_slide()
