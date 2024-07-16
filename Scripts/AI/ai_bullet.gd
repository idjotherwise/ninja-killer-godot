extends CharacterBody2D

#var target: Node;
#var speed: float = 100;
#var direction: Vector2;

func _process(delta):
	self.rotation += 1
	#if target and target.visible:
		#direction = (self.target.global_position - self.global_position).normalized()
		#velocity = direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.get("is_player"):
		if body.visible and self.visible:
			get_parent().get_parent().hit_player()
			get_parent().reset_bullet(self)
