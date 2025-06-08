extends StaticBody2D


func _ready() -> void:
	add_to_group('breakable')

func take_damage():
	queue_free()

func _on_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
	pass
	

