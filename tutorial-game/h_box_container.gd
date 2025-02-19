extends HBoxContainer

enum MODES {simple, empty, partial}

var heart_full = preload("res://art/hud_heartFull.png")
var heart_empty = preload("res://art/hud_heartEmpty.png")

@export var mode: MODES = MODES.simple
@export var max_health: int = 3  # Set max health
var current_health: int = max_health

func update_health(value: int):
	current_health = max(0, value)  # Ensure health doesn't go below 0
	redraw_hearts()

	if current_health == 0:
		get_tree().call_group("game", "game_over")  # Call game_over()

func redraw_hearts():
	for i in range(get_child_count()):
		var heart = get_child(i)
		heart.texture = heart_full if i < current_health else heart_empty
