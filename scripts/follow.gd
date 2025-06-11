extends PathFollow2D

@onready var main = get_node('/root/main')

var magic_item: Node2D


func _process(_delta: float) -> void:
	if magic_item == null:
		for child in get_children():
			if child.is_in_group('magic_item'):
				magic_item = child
				break;


	if magic_item != null:
		progress_ratio = pingpong(main.seconds() * (magic_item.speed / 10.0), 1)

