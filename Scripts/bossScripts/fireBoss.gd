extends KinematicBody2D


var speed = 2
export (Vector2) var dir
var timer = 5
var angle_to_player = 0;
signal fire (Fire, rotation, position)

func _ready():
	set_physics_process(true)
	#print(target)

func _physics_process(delta):
	var target = get_parent().find_node("Player")
	dir = (target.global_position - global_position).normalized()
	var distance = global_position.distance_to(target.global_position)
	set_global_rotation(current_angle())
	#print(distance)
	if distance > 100:
		move_and_collide(dir*speed)
	if distance < 100: #&& distance > 75:
		move_and_collide(-dir*(speed*1.5))  

func _process(delta):
	timer -= delta
	if timer<=0:
		attack()
		timer = 5

func current_angle():
	var player = get_parent().find_node("Player")
	angle_to_player = rad2deg(dir.angle_to(player.direction))
	return angle_to_player

func attack():
    print("Enemy is attacking")
    var player = get_parent().find_node("Player")
    var Fire = preload('res://Scenes/Player/Fire.tscn')
    emit_signal('fire', Fire, current_angle(), position)
    if position.distance_to(player.global_position) < 70:
        #direction = (player.global_position - global_position).normalized()
        
                #print(direction)
                #print(node.direction)
        print(abs(current_angle()))
                #I very clearly fucked this up but it works
        if abs(current_angle()) < 202.5 && abs(current_angle()) > 157.5:
            print('hit player')
        
        #print(deg2rad(float(facing)))

