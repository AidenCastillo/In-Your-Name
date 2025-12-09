extends Sprite2D

@export var flip_threshold: float = 0.1
# sprite flips based on movement direction
func update_sprite_flip(movement_direction: Vector2) -> void:
	if movement_direction.x > flip_threshold:
		flip_h = false
	elif movement_direction.x < -flip_threshold:
		flip_h = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
