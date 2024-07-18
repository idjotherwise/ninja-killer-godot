extends CharacterBody2D

var isAlive: bool = true;
var speed: int = 20;
var max_speed: int = 30;
var mob: bool = true;
var health: int = 2;

@onready var bar: ProgressBar = get_node("HealthBar");
@onready var tilemap: TileMap = get_node("../../TileMap")
@onready var player: Node = get_node("../../Player");
@onready var sprite: Sprite2D = get_node("GuardianSerpentOld");
@onready var anim: AnimatedSprite2D = get_node("Anim")
@onready var hud = get_node("../../HUD");
@onready var bullet_pool: Node = get_node("Bullets");

@onready var NavAgent: NavigationAgent2D = get_node("NavigationAgent2D");

var num_rays = 32;
var look_ahead = 100;
var steer_force = 0.1
var ray_directions = [];
var interest = [];
var danger = [];

var chosen_dir = Vector2.ZERO;

func _ready() -> void:
	interest.resize(num_rays);
	danger.resize(num_rays);
	ray_directions.resize(num_rays);
	for i in num_rays:
		var angle = i * 2 * PI / num_rays
		ray_directions[i] = Vector2.RIGHT.rotated(angle)
	
	bar.max_value = health
	call_deferred("actor_setup")
	
func actor_setup()-> void:
	await get_tree().physics_frame
	set_movement_target(player.global_position)
	
func set_movement_target(vec: Vector2) -> void:
	NavAgent.target_position = player.global_position
	
func _physics_process(delta: float) -> void:
	if isAlive:
		bar.value = health
		get_node("CollisionShape2D").disabled = false
		var current_agent_position: Vector2 = global_position
		var next_path_position: Vector2 = NavAgent.get_next_path_position()
		var direction = current_agent_position.direction_to(next_path_position)
		velocity = direction * speed
		move_and_slide()
		
		
		
		if direction.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
		anim.hide()
		sprite.show()
		bar.show()
		
		move_and_slide()
	else:
		bar.hide()
		anim.show()
		get_node("CollisionShape2D").disabled = true
		sprite.hide()

func reset_mob(body: Node) -> void:
	if health > 1:
		health -= 1
	else:
		isAlive = false
		anim.play("Death")
		await anim.animation_finished
		get_parent().reset_mob(body)
		

func _on_player_detection_body_entered(body: Node2D):
	if "Player" in body.name:
		if self.visible and body.visible:
			var p = 1;
			if "2" in body.name:
				p = 2;
			hit_player(p)

func hit_player(player: int) -> void:
	if player == 1:
		Game.player_hp -= 1
	else:
		Game.player2_hp -= 1

func shoot_bullet() -> void:
	# Cheap way to make the shot timer more spread out
	if self.visible and randf() < 0.3:
		var bulletTemp: Node = bullet_pool.get_bullet()
		var direction: Vector2 = (player.global_position - get_node("SpawnPoint").global_position).normalized()
		bulletTemp.velocity = direction * 140
		bulletTemp.global_position = get_node("SpawnPoint").global_position
		bulletTemp.show()
		
func _on_shoot_bullet_timeout():
	shoot_bullet()


func _on_change_dir_timer_timeout():
	set_movement_target(player.global_position) # Replace with function body.
