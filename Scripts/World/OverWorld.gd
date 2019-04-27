extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Player_fire(Fire, direction, position):
	var f = Fire.instance()
	add_child(f)
	f.rotation = direction
	f.position = position
	f.velocity = f.velocity.rotated(direction)