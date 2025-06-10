class_name  MagicItem
extends RigidBody2D

@onready var graphics = $Graphics

@export var possible_items : Array[MagicItemData]

@export_subgroup('Set Item Properties')
@export var set_item : bool = false
@export var set_item_ind : int = 0

@export_subgroup('Respawn Properties')
@export var respawn : bool = false
@export var respawn_time : float = 1

var energy : float = 0

signal EnergyOut
signal EnergyChange(amount:float)

func _ready() -> void:
	get_data()
	add_to_group('drainable')

func _physics_process(_delta):
	linear_velocity = Vector2.ZERO

func set_data(spr : SpriteFrames, enr : float):
	graphics.sprite_frames = spr
	energy = enr

func get_data():
	var data : MagicItemData
	if set_item:
		data = possible_items[set_item_ind]
	else:
		data = possible_items[randi_range(0, possible_items.size() - 1)]
	
	set_data(data.sprite_frames, data.energy)

func drain_energy(amount) -> float:
	energy -= amount
	if energy <= 0:
		energy_out()
	
	EnergyChange.emit(energy)
	
	return amount

func energy_out():
	EnergyOut.emit()
	
	if !respawn:
		queue_free()
	
	#gross but works
	modulate.a = 0
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	await get_tree().create_timer(respawn_time).timeout
	modulate.a = 255
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	
	get_data()
