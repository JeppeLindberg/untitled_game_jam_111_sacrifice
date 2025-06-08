extends RigidBody2D

var movement_direction: Vector2
var draining_from_nodes: Array

@onready var debug_spawner = get_node('/root/main/debug_spawner')
@onready var drain_lines = get_node('drain_lines')

@export var movement_speed : float


func _process(delta: float) -> void:
	for child in drain_lines.get_children():
		child.queue_free()
	
	for node in draining_from_nodes:
		drain_lines.add_line_between(self, node)


func _physics_process(delta):

	handle_controls(delta)

	linear_velocity = movement_direction * movement_speed

	
	
func start_draining(node):
	draining_from_nodes.append(node)

func stop_draining(node):
	draining_from_nodes.erase(node)


func handle_controls(_delta):

	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	movement_direction = input.normalized()


