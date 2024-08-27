class_name MainGameScript
extends Node2D

## 100 = all bar in 1 s
const SPEED = 30

var BAR_START = Vector2(136,509)
var BAR_END = Vector2(1187,485)

@onready var arrow : Polygon2D = $Bar/Arrow
@onready var happy : RichTextLabel = $Hapiness

var arrow_pct : float
var goal_pct : float = 0.5
var score : float
var time_left : float = 60 * 1 + 10


func _process(delta : float):
	#input
	var action_pressed = Input.is_action_just_pressed("main_action")

	game_logic(delta, action_pressed)

	# visuals
	arrow.position = lerp(BAR_START, BAR_END, arrow_pct)
	happy.text = label_text()


func game_logic(delta:float, action_pressed : bool) -> void:
	if time_left < 0:
		return

	arrow_pct -= delta * SPEED / 100.0
	if action_pressed:
		arrow_pct += 0.1
	arrow_pct = clamp(arrow_pct, 0 ,1)
	score += delta * score_per_second()
	time_left -= delta


func score_per_second() -> float:
	var err = abs(arrow_pct - goal_pct)
	match (err):
		var p when p < 0.1: return 100
		var p when p < 0.3: return 10
		_: return 0


func format_time_left() -> String:
	return "%d : %02d" % [ time_left / 60, fmod(time_left, 60) ]


func label_text() -> String:
	var result : String = "Hapiness: %d" % [score];
	result += "\n" + format_time_left()
	result += "\n %.0f" % [arrow_pct*100]
	return result
