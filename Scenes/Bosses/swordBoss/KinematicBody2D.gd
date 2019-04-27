extends KinematicBody2D


var speed = 1



func _ready():
	set_physics_process(true)
	#print(target)

func _physics_process(delta):
	var target = get_parent().find_node("Player")
	var direction = (target.global_position - global_position).normalized()
	var distance = global_position.distance_to(target.global_position)
	#print(distance)
	if distance > 100:
		move_and_collide(direction*speed) 

#func _process(delta):
	#var direction = (target.global_position - global_position).normalized()
	#var distance = sqrt(pow((target.global_position.x - position.x),2) + pow((target.global_position.y - position.y),2))
	#print(distance)
	#if direction.length() >1:
	#move_and_collide(direction*speed) 