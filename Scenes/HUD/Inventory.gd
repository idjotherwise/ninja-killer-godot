extends GridContainer


	
func draw_inventory():
	var inventory  = get_tree().get_node("../Player/Inventory")
	for item in inventory.items:
		draw(item)

			
func draw(item: Item):
	var container = PanelContainer.new();
	var slot_rect = TextureRect.new();
	slot_rect.texture = item.inventory_texture
	container.add_child(slot_rect)
	add_child(container)
