extends CanvasLayer
	
var score = 0;
	
func _ready() -> void:
	score = 0;
	update_score(score);
	show_message("Go!")
	
func show_message(text: String) -> void:
	$Message.text = text
	$AnimationPlayer.play("show_message")
	

func update_score(value: int) -> void:
	$ScoreBox/HBoxContainer/Score.text = str(value)

func increment_score() -> void:
	score += 1
	update_score(score)
