extends RigidBody2D

@onready var path = get_node('path')
@onready var paths = get_node('/root/main/world/paths')
@onready var follow = get_node('path/follow')
@onready var health_mask = get_node('health_mask')
@onready var health_sprite = get_node('health_mask/health')
@onready var main = get_node('/root/main')

var initialized = false

@export var unkillable = false
@export var speed = 5.0
@export var drainable_seconds = 10.0

var health = 1.0

var full_health_vec: Vector2 = Vector2.ZERO
var no_health_vec: Vector2 = Vector2(-100.0, 0.0)


func _ready() -> void:
	add_to_group('drainable')
	add_to_group('magic_item')

func _process(_delta: float) -> void:
	if not initialized:
		path.reparent(paths)
		self.reparent(follow)
		initialized = false
	
	if (health <= 0) and not unkillable:
		queue_free()
		for number_incrementer in main.get_children_in_group(main, 'number_incrementer'):
			number_incrementer.increment()

	if unkillable:
		health_mask.modulate.a = 0.0
	else:
		health_sprite.position = lerp(no_health_vec, full_health_vec, health)

func _physics_process(_delta):
	linear_velocity = Vector2.ZERO
