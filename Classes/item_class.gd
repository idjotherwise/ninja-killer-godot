@tool
extends Resource

class_name Item

@export var name: String;
@export var sprite_texture: Texture2D;
@export var inventory_texture: Texture2D;
func _init(_name="Sword") -> void:
	name = _name
