extends Node2D

var mob_scene: PackedScene = preload("res://Scenes/AI/sneak_mob.tscn")

var pool_size: int = 10;
var mob_pool: Array = [];

@onready var timer: Timer = get_node("Timer");
@onready var hud = get_parent().get_node("HUD");

func _ready() -> void:
	for i in range(pool_size):
		var mob: Node = mob_scene.instantiate()
		mob.hide()
		mob_pool.append(mob)
		add_child(mob)
		

func get_mob() -> Node2D:
	for mob in mob_pool:
		if not mob.visible:
			return mob
	var new_mob: Node2D = mob_scene.instantiate() as Node2D
	new_mob.hide()
	mob_pool.append(new_mob)
	add_child(new_mob)
	return new_mob

func nearest_enemy_to(pos: Vector2):
	var smallest_dist: float = 0.0;
	var closest_mob: Node;
	for mob in mob_pool:
		if not mob.visible:
			continue
		var distance_to_pos = mob.global_position.distance_squared_to(pos)
		if distance_to_pos < smallest_dist or smallest_dist == 0.0:
			smallest_dist = distance_to_pos
			closest_mob = mob
	return closest_mob
	
func reset_mob(mob: Node) -> void:
	mob.global_position = Vector2(-10000, -10000)
	mob.get_node("CollisionShape2D").disabled = false
	mob.isAlive = true
	mob.health = 5
	mob.get_node("HealthBar").value = 0
	mob.hide()
	hud.increment_score()


func _on_timer_timeout() -> void:
	var mobTemp: Node = get_mob()
	var randX: int = randi_range(-50, 50)
	var randY: int = randi_range(-50, 50)
	mobTemp.global_position = self.global_position + Vector2(randX, randY)
	mobTemp.show()
