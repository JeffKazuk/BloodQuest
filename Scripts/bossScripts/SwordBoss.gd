extends KinematicBody2D


var speed = 1
var velocity = 0
var timer = 3
var angle_to_player
var player
var distance =0
var attack_timer = 80000
signal hit_player

func _ready():
	set_physics_process(true)
	#print(target)

func _physics_process(delta):
	var target = get_parent().find_node("Player")
	velocity = (target.global_position - global_position).normalized()
	distance = global_position.distance_to(target.global_position)
	#print(distance)
	if distance >= 100:
		move_and_collide(velocity*speed)
	
	

func _process(delta):
	attack_timer -= delta
	timer -= delta
	if timer<=0:
		if distance <= 150:
			attack_timer = .2
			speed = 0
			attack_timer = .2
			speed = 0
		timer = rand_range(0,2)
	#print(rotation)
	var facing = 'E'
	var angle = velocity.angle()
	#print(angle)
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
	if attack_timer <= 0:
		attack_timer = 80000
		attack()
		speed = 1
	$AnimatedSprite.animation = facing

func current_angle():
	angle_to_player = rad2deg(position.angle_to_point(player.position))
	#print(angle_to_player)
	return angle_to_player

func attack():
    print("Enemy is attacking")
    var player = get_parent().find_node("Player")
    if position.distance_to(player.global_position) < 150:
        #velocity = (player.global_position - global_position).normalized()
        #var angle_to_player = rad2deg(velocity.angle_to(player.velocity))
                #print(velocity)
                #print(node.velocity)
        #print(abs(angle_to_player))
                #I very clearly fucked this up but it works
        #if abs(angle_to_player) < 202.5 && abs(angle_to_player) > 157.5:
        emit_signal('hit_player')

