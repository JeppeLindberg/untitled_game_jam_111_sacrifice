extends RigidBody2D

var movement_direction: Vector2
var draining_from_nodes: Array

@onready var debug_spawner = get_node('/root/main/debug_spawner')
@onready var drain_lines = get_node('drain_lines')
@onready var sprite = get_node('sprite')
@onready var health_sprite = get_node('health_mask/health')
@onready var world = get_node('/root/main/world')
@onready var camera = get_node('camera')

@export var movement_speed : float
var movement_speed_mult = 1.0

var health = 1.0

var full_health_vec: Vector2 = Vector2.ZERO
var no_health_vec: Vector2 = Vector2(-100.0, 0.0)


func _process(delta: float) -> void:
	for child in drain_lines.get_children():
		child.queue_free()
	
	var is_draining = false

	for node in draining_from_nodes:
		drain_lines.add_line_between(self, node)
		is_draining = true
		node.health -= delta * (1/node.drainable_seconds)
		health += delta

	if not is_draining:
		var seconds_survive_without_drain = 5.0
		health -= delta / seconds_survive_without_drain
		movement_speed_mult = 1.0
	else:
		movement_speed_mult = 1.0
	
	if health > 1.0:
		health = 1.0

	health_sprite.position = lerp(no_health_vec, full_health_vec, health)

	if health <= 0.0:
		camera.get_node('game').visible = false
		camera.get_node('total').visible = true
		camera.reparent(world)
		queue_free()


func _physics_process(delta):

	handle_controls(delta)

	linear_velocity = movement_direction * movement_speed * movement_speed_mult

	
	
func start_draining(node):
	draining_from_nodes.append(node)

func stop_draining(node):
	draining_from_nodes.erase(node)


func handle_controls(_delta):

	var input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	movement_direction = input.normalized()
	if movement_direction.dot(Vector2.LEFT) > 0:
		sprite.scale = Vector2(-1.0, 1.0);
	if movement_direction.dot(Vector2.RIGHT) > 0:
		sprite.scale = Vector2(1.0, 1.0);
