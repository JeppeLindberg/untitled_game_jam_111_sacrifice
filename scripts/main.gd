extends Node2D

var _seconds = 0.0

func _process(delta: float) -> void:
	_seconds += delta

func seconds():
	return _seconds


var _result


func get_children_in_group(node, group):
	_result = []

	_get_children_in_group_recursive(node, group)

	return _result

func _get_children_in_group_recursive(node, group):
	for child in node.get_children():
		if child.is_in_group(group):
			_result.append(child)

		_get_children_in_group_recursive(child, group)