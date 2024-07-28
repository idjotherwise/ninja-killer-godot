@tool
extends Node2D

@export var item: Item;
@onready var inventory_script = preload("res://Scenes/HUD/Inventory.gd");

# TODO: Revert collision layer to 4 when it is fixed

func _ready():
	var texture: Texture2D = load(item.sprite_texture.resource_path);
	var node = Sprite2D.new();
	node.texture = texture;
	add_child(node)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		var inv: Array[Item] = body.get_node("Inventory").items
		inv.append(item)
		var inventory = inventory_script.new();
		inventory.draw_inventory()
		queue_free()
