extends Node2D

@onready var finalScore = get_node("FinalScore");

# Called when the node enters the scene tree for the first time.
func _ready():
	finalScore.text = "Final Score: " + str(Game.score);


func _on_button_pressed():
	Game.score = 0;
	Game.player_hp = Game.player_max_hp;
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
