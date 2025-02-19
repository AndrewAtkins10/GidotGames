extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print($Player/Camera2D.global_position)
	


func _on_kill_plane_area_entered(area: Area2D) -> void:
	var player = get_node("/root/Main/Player")  # Adjust path if needed	
	var spawn_point = player.get_node("Marker2D").global_position  # Get Marker2D position
	player.global_position = spawn_point  # Reset player position	
