extends KinematicBody2D


var speed = 2
export (Vector2) var direction
var timer = 5
var angle_to_player = 0;
signal fire (Fire, rotation, position)
var player

func _ready():
	set_physics_process(true)
	direction = Vector2()
	player = get_parent().find_node("Player")
	#print(target)

func _physics_process(delta):
	var target = get_parent().find_node("Player")
	direction = (target.global_position - global_position).normalized()
	var distance = global_position.distance_to(target.global_position)
	#$set_global_rotation(deg2rad(current_angle()))
	#print(distance)
	if distance > 100:
		move_and_collide(direction*speed)
	if distance < 100: #&& distance > 75:
		move_and_collide(-direction*(speed*1.5))  

func _process(delta):
	timer -= delta
	if timer<=0:
		attack()
		timer = 5
	print(rotation)
	var facing = 'E'
	var angle = direction.angle()
	print(angle)
	if angle > PI/8 && angle < 3*PI/8:
		facing = 'SE'
	if angle > 3*PI/8 && angle < 5*PI/8:
		facing = 'S'
	if angle > 5*PI/8 && angle < 7*PI/8:
		facing = 'SW'
	if angle > 7*PI/8 && angle < PI:
		facing = 'W'
	if angle > -PI/8 && angle < PI/8:
		facing = 'E'
	if angle > -3*PI/8 && angle < -PI/8:
		facing = 'NE'
	if angle > -5*PI/8 && angle < -3*PI/8:
		facing = 'N'
	if angle > -7*PI/8 && angle < -5*PI/8:
		facing = 'NW'
	if angle > -PI && angle < -7*PI/8:
		facing = 'W'

	$AnimatedSprite.animation = facing

func current_angle():
	angle_to_player = rad2deg(position.angle_to_point(player.position))
	#print(angle_to_player)
	return angle_to_player

func attack():
    print("Enemy is attacking")
    var player = get_parent().find_node("Player")
    var Fire = preload('res://Scenes/Player/Fire.tscn')
    emit_signal('fire', Fire, direction.angle(), position)
    if position.distance_to(player.global_position) < 70:
        #direction = (player.global_position - global_position).normalized()
        
                #print(direction)
                #print(node.direction)
        print(abs(current_angle()))
                #I very clearly fucked this up but it works
        if abs(current_angle()) < 202.5 && abs(current_angle()) > 157.5:
            print('hit player')
        
        #print(deg2rad(float(facing)))

