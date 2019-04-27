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
func _on_Player_fire(Fire, angle, position):
	var f = Fire.instance()
	var rot = 0
	add_child(f)
	if angle > PI/8 && angle < 3*PI/8:
	    rot = PI/4
	if angle > 3*PI/8 && angle < 5*PI/8:
	    rot = PI/2
	if angle > 5*PI/8 && angle < 7*PI/8:
	    rot = 3*PI/4
	if angle > 7*PI/8 && angle < PI:
	    rot = PI
	if angle > -PI/8 && angle < PI/8:
	    rot = 0
	if angle > -3*PI/8 && angle < -PI/8:
	    rot = -PI/4
	if angle > -5*PI/8 && angle < -3*PI/8:
	    rot = -PI/2
	if angle > -7*PI/8 && angle < -5*PI/8:
	    rot = -3*PI/4
	if angle > -PI && angle < -7*PI/8:
	    rot = -PI
	f.rotation = rot
	f.position = position
	f.velocity.x = cos(rot)
	f.velocity.y = sin(rot)