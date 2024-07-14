extends CharacterBody2D

func _process(delta):
	self.rotation += 1
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.get("mob"):
		if body.isAlive and body.visible and self.visible:
			body.hit(body)
			get_parent().reset_bullet(self)
