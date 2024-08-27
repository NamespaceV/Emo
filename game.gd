class_name MainGameScript
extends Node2D

## 100 = all bar in 1 s
const SPEED = 30

var BAR_START = Vector2(42,573)
var BAR_END = Vector2(1094,544)

@onready var arrow : Polygon2D = $Arrow
@onready var happy : RichTextLabel = $Hapiness

var arrow_pct :  float


func _process(delta : float):
	arrow_pct += delta * SPEED / 100.0
	arrow_pct = clamp(arrow_pct, 0 ,1)
	arrow.position = lerp(BAR_START, BAR_END, arrow_pct)
