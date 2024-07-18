extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.connect("joy_connection_changed", _joy_connection_changed)
	get_node("PlayersOption").selected = len(Input.get_connected_joypads())


func _joy_connection_changed():
	get_node("PlayersOption").selected = len(Input.get_connected_joypads())


func _on_start_pressed():
	Game.num_players = get_node("PlayersOption").selected + 1
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_exit_pressed():
	get_tree().quit()
