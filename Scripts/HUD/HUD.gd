extends CanvasLayer
	

func _ready() -> void:
	show_message("Go!")
	
func show_message(text: String) -> void:
	$Message.text = text
	$AnimationPlayer.play("show_message")

