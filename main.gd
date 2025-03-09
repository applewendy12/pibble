extends Node


func new_game():
	$Player1.start($P1StartPosition.position)
	$Player2.start($P2StartPosition.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

