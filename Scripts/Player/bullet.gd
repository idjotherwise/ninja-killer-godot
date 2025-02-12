extends CharacterBody2D

var target: Node;
var speed: float = 100;
var direction: Vector2;

func _process(_delta):
	self.rotation += 1
	if target and target.visible:
		direction = (self.target.global_position - self.global_position).normalized()
		velocity = direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.get("mob"):
		if body.isAlive and body.visible and self.visible:
			body.reset_mob(body)
			get_parent().reset_bullet(self)


func _on_visible_on_screen_notifier_2d_screen_exited():
	get_parent().reset_bullet(self)
