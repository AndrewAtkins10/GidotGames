extends Node

@export var mob_scene: PackedScene
var score
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("game")
	$Player.hit.connect(_on_Player_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func game_over():
	$HUD/highScore.show()
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	

func new_game():
	score=0
	$HUD/hearts.current_health = $HUD/hearts.max_health
	$HUD/hearts.redraw_hearts()
	$HUD/hearts.current_health = $HUD/hearts.max_health
	$HUD/hearts.redraw_hearts()
	$HUD/highScore.hide() 

	get_tree().call_group("mobs","queue_free")
	$Music.play()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	
func _on_mob_timer_timeout() -> void:
	
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf();
	var direction = mob_spawn_location.rotation + PI / 2
	direction +=randf_range(-PI/4, PI/4)
	mob.rotation = direction
	mob.position = mob_spawn_location.position
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	mob.linear_velocity= velocity.rotated(direction)
	
	add_child(mob)
	
	

func _on_score_timer_timeout() -> void:
	score+=1
	$HUD.update_score(score)

func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
func _on_Player_hit():
	var health_ui = get_node("HUD/hearts")
	health_ui.update_health(health_ui.current_health-1)
