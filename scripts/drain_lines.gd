extends Node2D

@export var line_prefab: PackedScene


func add_line_between(from, to):
	var new_line = line_prefab.instantiate()
	add_child(new_line)
	new_line.position = Vector2.ZERO
	new_line.points = [
		from.global_position - new_line.global_position,
		to.global_position - new_line.global_position
	]

