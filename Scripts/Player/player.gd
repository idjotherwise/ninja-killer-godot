extends CharacterBody2D

var is_player: bool = true;
var speed: int = 75;
var direction: Vector2 = Vector2(0, 1);
@onready var bullet_pool: Node = get_node("Bullets");
@onready var enemies_pool: Node = get_parent().get_node("Portal");
var player_number: int = 1;
var controlls: Dictionary = {
	"left": "ui_left",
	"right": "ui_right",
	"up": "ui_up",
	"down": "ui_down",
	"shoot": "shoot",
}
func _physics_process(_delta: float) -> void:
	var inputDir: Vector2 = Vector2(
		Input.get_axis(controlls["left"], controlls["right"]),
		Input.get_axis(controlls["up"], controlls["down"])
		).normalized()
		
	if inputDir.x > 0: # RIGHT
		get_node("Character").flip_h = true
		get_node("AnimationPlayer").play("WalkingDown")
		direction = inputDir
	elif inputDir.x < 0: # LEFT
		get_node("Character").flip_h = false
		get_node("AnimationPlayer").play("WalkingDown")
		direction = inputDir
	elif inputDir.y > 0: # DOWN
		get_node("AnimationPlayer").play("WalkingDown")
		direction = inputDir
	elif inputDir.y < 0: # UP
		get_node("AnimationPlayer").play("WalkingDown")
		direction = inputDir
		
	get_node("SpawnPoint").position = direction * 5
	if Input.is_action_just_pressed(controlls["shoot"]):
		var nearest_mob = enemies_pool.nearest_enemy_to(self.global_position);
		var bulletTemp = bullet_pool.get_bullet(nearest_mob)
		bulletTemp.global_position = get_node("SpawnPoint").global_position
		
		bulletTemp.target = nearest_mob;
		bulletTemp.velocity = direction * 100;
		bulletTemp.show();
		bulletTemp.get_node("PlayerBullet").play("spin");
	
	if Game.player_hp <= 0:
		get_tree().change_scene_to_file("res://Scenes/game_over.tscn")
	
	velocity = inputDir * speed;
	
	move_and_slide()
	

