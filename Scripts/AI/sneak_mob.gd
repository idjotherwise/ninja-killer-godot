extends CharacterBody2D

var isAlive: bool = true;
var speed: int = 20;
var mob: bool = true;
var health: int = 5;
@onready var bar: ProgressBar = get_node("HealthBar");
@onready var player: Node = get_node("../../Player");
@onready var sprite: Sprite2D = get_node("GuardianSerpentOld");
@onready var anim: AnimatedSprite2D = get_node("Anim")
@onready var hud = get_node("../../HUD");

func _ready() -> void:
	bar.max_value = health

func _physics_process(delta: float) -> void:
	if isAlive:
		bar.value = health
		get_node("CollisionShape2D").disabled = false
		var direction: Vector2 = (player.global_position - self.global_position).normalized()
		self.velocity = speed * direction
		
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
			Game.player_hp -= 1
			hud.update_health(Game.player_hp)
			if Game.player_hp <= 0:
				get_tree().reload_current_scene();
