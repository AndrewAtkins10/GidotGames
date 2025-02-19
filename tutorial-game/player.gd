extends Area2D

@export var speed=400 #pixels/sec
var screen_size

signal hit
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x +=1
	if Input.is_action_pressed("move_left"):
		velocity.x -=1
	if Input.is_action_pressed("move_backwards"):
		velocity.y +=1
	if Input.is_action_pressed("move_forward"):
		velocity.y -=1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$playerAnimation.play()
	else:
		$playerAnimation.stop()

	
	position += velocity *delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x !=0:
		$playerAnimation.animation = "walk"
		$playerAnimation.flip_h = velocity.x < 0
		$playerAnimation.flip_v = false
	elif velocity.y !=0:
		$playerAnimation.animation ="up"
		$playerAnimation.flip_v= velocity.y > 0
	
	


func _on_body_entered(body: Node2D) -> void:
	count+=1
	if count==3:
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled",true)
		$hitSound.play()
		count=0
	else:
		hit.emit()
		$hitSound.play()
func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false
	
