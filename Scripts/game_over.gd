extends Node2D

@onready var finalScore = get_node("FinalScore");

# Called when the node enters the scene tree for the first time.
func _ready():
	finalScore.text = "Final Score: " + str(Game.score);


func _on_button_pressed():
	reset_state();
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func reset_state():
	Game.score = 0;
	Game.player_hp = Game.player_max_hp;
	Game.player2_hp = Game.player2_max_hp;

func _on_main_menu_pressed():
	reset_state()
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn") # Replace with function body.
