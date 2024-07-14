extends CharacterBody2D

var isAlive: bool = true;
var speed: int = 20;
var mob: bool = true;
var health: int = 5;
@onready var bar: ProgressBar = get_node("HealthBar");
@onready var player: Node = get_node("../../Player");
@onready var sprite: Sprite2D = get_node("GuardianSerpentOld");

func _ready() -> void:
	bar.max_value = health

func _physics_process(delta: float) -> void:
	if isAlive:
		bar.value = health
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
	if health > 1:
		health -= 1
	else:
		get_parent().reset_mob(body)

func _on_area_2d_body_entered(body):
	push_error("thi")
	if body.get("player"):
		get_tree().reload_current_scene();

