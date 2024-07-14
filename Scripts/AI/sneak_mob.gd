extends CharacterBody2D

var isAlive: bool = true;
var speed: int = 20;
var mob: bool = true;
var health: int = 2;
@onready var player: Node = get_node("../../Player");
@onready var sprite: Sprite2D = get_node("GuardianSerpentOld");

func _physics_process(delta: float) -> void:
	if isAlive:
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		velocity = speed * direction
		move_and_slide()
		
		if direction.x < 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		self.hide()

func reset_mob(body: Node) -> void:
	get_parent().reset_mob(body)

func hit(body: Node) -> void:
	var new_health: int = body.get("health") - 1;
	if new_health <= 0:
		reset_mob(body)
	else:
		body.health = new_health
		$HealthBar.value = new_health
	
