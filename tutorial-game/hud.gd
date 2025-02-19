extends CanvasLayer
signal start_game
var highScore = 0
var prevHigh = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _process(delta: float) -> void:
	pass
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
func show_game_over():
	show_message("Game Over")
	$MessageTimer.stop()
	if highScore>prevHigh:
		prevHigh=highScore
		$highScore.text= "New High Score!! " + str(highScore)
	else:
		$highScore.text= "Not a high Score! Try again!"
	# Wait until the MessageTimer has counted down.
	await get_tree().create_timer(3.0).timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.5).timeout

	$StartButton.show()
func update_score(score):
	$ScoreLabel.text = str(score)
	if score>highScore:
		highScore=score
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()
