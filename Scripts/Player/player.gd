extends CharacterBody2D

var speed: int = 75;
var direction: Vector2 = Vector2(0, 1);
@onready var bullet_pool = get_node("Bullets");

func _physics_process(delta: float) -> void:
	var inputDir: Vector2 = Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
		).normalized()
		
	if inputDir.x > 0:
		get_node("Player").frame = 1
		get_node("Player").flip_h = false
		# check if player is moving right
		direction = inputDir
	elif inputDir.x < 0:
		# check if player is moving left
		get_node("Player").frame = 1
		get_node("Player").flip_h = true
		direction = inputDir
	elif inputDir.y > 0:
		# moving down
		get_node("Player").frame = 0
		get_node("Player").flip_h = false
		direction = inputDir
	elif inputDir.y < 0:
		# moving up
		get_node("Player").frame = 2
		get_node("Player").flip_h = false
		direction = inputDir
	get_node("SpawnPoint").position = direction * 5
	if Input.is_action_just_pressed("shoot"):
		var bulletTemp = bullet_pool.get_bullet()
		bulletTemp.velocity = direction * 100
		bulletTemp.global_position = get_node("SpawnPoint").global_position
		bulletTemp.show()
	
	velocity = inputDir * speed
	move_and_slide()
	
