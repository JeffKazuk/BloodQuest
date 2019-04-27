extends KinematicBody2D


var speed = 2
export var direction = 0
var timer = 5

func _ready():
	set_physics_process(true)
	#print(target)

func _physics_process(delta):
	var target = get_parent().find_node("Player")
	direction = (target.global_position - global_position).normalized()
	var distance = global_position.distance_to(target.global_position)
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

func attack():
    print("Enemy is attacking")
    var player = get_parent().find_node("Player")
    if position.distance_to(player.global_position) < 70:
        #direction = (player.global_position - global_position).normalized()
        var angle_to_player = rad2deg(direction.angle_to(player.direction))
                #print(direction)
                #print(node.direction)
        print(abs(angle_to_player))
                #I very clearly fucked this up but it works
        if abs(angle_to_player) < 202.5 && abs(angle_to_player) > 157.5:
            print('hit player')

