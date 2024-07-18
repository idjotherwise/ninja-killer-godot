extends Node2D

var num_players: int = 1;

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.connect("joy_connection_changed", _joy_connection_changed)
	var connected_joypads = Input.get_connected_joypads()
	get_node("NumPlayers").text = str(len(connected_joypads) + num_players)



func _joy_connection_changed():
	get_node("NumPlayers").text = str(len(Input.get_connected_joypads()) + num_players)


func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
