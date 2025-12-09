extends Node

# Scene travel data
var target_scene: String = ""
var spawn_point: String = "Spawn"

# Player persistent data
var inventory: Array[String] = []
var visited_rooms := {}

var battery: float = 100.0
# For future meta-horror flags
var reality_shift_level: int = 0


# Call this before changing scene
func request_scene_change(scene_path: String, spawn: String):
	target_scene = scene_path
	spawn_point = spawn
