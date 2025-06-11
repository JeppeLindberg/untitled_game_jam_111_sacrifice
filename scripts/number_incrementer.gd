extends Label

func _ready() -> void:
	add_to_group('number_incrementer')

func increment():
	var num = int(text)
	num += 1
	text = str(num)
