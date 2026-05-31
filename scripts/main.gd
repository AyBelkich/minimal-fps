extends Node3D

var score := 0

@onready var score_label: Label = $UI/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func add_score(amount: int):
	score += amount
	score_label.text = "Score: " + str(score)
