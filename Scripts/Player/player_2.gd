extends CharacterBody2D


var speed: int = 75;
var direction: Vector2 = Vector2(0, 1);
@onready var bullet_pool: Node = get_node("Bullets");
@onready var enemies_pool: Node = get_parent().get_node("Portal");
var is_player: bool = true;
var controlls: Dictionary = {
	"left": "ui_left2",
	"right": "ui_right2",
	"up": "ui_up2",
	"down": "ui_down2",
	"shoot": "shoot2",
}
func _physics_process(delta: float) -> void:
	var inputDir: Vector2 = Vector2(
		Input.get_axis(controlls["left"], controlls["right"]),
		Input.get_axis(controlls["up"], controlls["down"])
		).normalized()
		
	if inputDir.x > 0:
		# TODO: reenable these animations once there are multiple frames for the Character
		get_node("Character").frame = 2
		# check if Character is moving right
		direction = inputDir
	elif inputDir.x < 0:
		# check if Character is moving left
		get_node("Character").frame = 3

		direction = inputDir
	elif inputDir.y > 0:
		# moving down
		get_node("Character").frame = 1

		direction = inputDir
	elif inputDir.y < 0:
		# moving up
		get_node("Character").frame= 0

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
	
	velocity = inputDir * speed;
	move_and_slide()
	

