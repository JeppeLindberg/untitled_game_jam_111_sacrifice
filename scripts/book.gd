extends RigidBody2D


func _ready() -> void:
	add_to_group('drainable')


func _physics_process(_delta):
	linear_velocity = Vector2.ZERO

