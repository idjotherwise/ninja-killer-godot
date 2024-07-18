extends Node2D

@onready var player2 = preload("res://Scenes/Player/player_2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if Game.num_players == 2:
		var instance = player2.instantiate()
		instance.position = Vector2(200, 100)
		add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
