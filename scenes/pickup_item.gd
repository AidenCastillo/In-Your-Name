extends Node2D

var is_held := false
var holder: Node2D = null

func pick_up(parent: Node2D):
	is_held = true
	holder = parent
	position = Vector2(0, -8)  # moves item slightly above the HoldPoint
	var old_parent = get_parent()
	old_parent.remove_child(self)
	parent.add_child(self)

func drop(world_parent: Node2D):
	is_held = false
	reparent(world_parent)
	global_position = holder.global_position
	holder = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("player entered")
		body.pick_up_item(self)
