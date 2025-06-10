extends Area2D


@onready var player = get_parent()


func _on_body_exited(body:Node2D) -> void:
	if body.is_in_group('drainable'):
		player.stop_draining(body)

func _on_body_entered(body:Node2D) -> void:
	print('bla')
	if body.is_in_group('drainable'):
		player.start_draining(body)
