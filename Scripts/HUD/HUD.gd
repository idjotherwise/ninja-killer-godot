extends CanvasLayer
	

func _ready() -> void:
	if Game.num_players == 2:
		$Player2Name.visible = true
		$Health2.visible = true
	show_message("Go!")
	
func show_message(text: String) -> void:
	$Message.text = text
	$AnimationPlayer.play("show_message")

