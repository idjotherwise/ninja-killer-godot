extends CharacterBody2D

var target: Node;
var speed: float

func _process(delta):
	self.rotation += 1
	if target:
		velocity = (self.target.global_position - self.global_position).normalized() * speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.get("mob"):
		if body.isAlive and body.visible and self.visible:
			body.hit(body)
			get_parent().reset_bullet(self)
