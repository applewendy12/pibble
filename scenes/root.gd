extends Node2D


func _ready():
	$Camera2D.add_target($evilarry)
	$Camera2D.add_target($realpibble)
	# $Camera2D.limit_left = r.position.x * ce
	# $Camera2D.limit_right = r.end.x * cell_s
