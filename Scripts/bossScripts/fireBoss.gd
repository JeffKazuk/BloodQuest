extends KinematicBody2D


var speed = 2
var velocity=0
var timer = rand_range(1,3)
var angle_to_player = 0;
signal fire (Fire, rotation, position)
var player
var distance = 0

func _ready():
	set_physics_process(true)
	player = get_parent().find_node("Player")
	$Health.connect('health_depleted', self, 'dead')
	$Area2D.connect('area_entered', self, '_on_hit_by_fireball')
	#print(target)

func _physics_process(delta):
	var target = get_parent().find_node("Player")
	velocity = (target.global_position - global_position).normalized()
	distance = global_position.distance_to(target.global_position)
	#$set_global_rotation(deg2rad(current_angle()))
	#print(distance)
	if distance >= 125:
		move_and_collide(velocity*speed)
	if distance <=124: #&& distance > 75:
		move_and_collide(-velocity*(speed*1.5))  

func _process(delta):
	timer -= delta
	if timer<=0:
		attack()
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

	$AnimatedSprite.animation = facing

func _on_hit_by_fireball(area):
	$Health.take_damage(7)
	print('gadersk')

func current_angle():
	angle_to_player = rad2deg(position.angle_to_point(player.position))
	#print(angle_to_player)
	return angle_to_player

func attack():
    print("Enemy is attacking")
    var player = get_parent().find_node("Player")
    var Fire = preload('res://Scenes/Bosses/fireBoss/MeanGuyFire.tscn')
    emit_signal('fire', Fire, velocity.angle(), position)

func _get_hit(damage):
	print('yeowch')
	$Health.take_damage(damage)

func dead():
	get_parent().get_node('FireBossActivator').spawnable = false
	var fire = preload('res://Scenes/World/World Boots.tscn')
	fire = fire.instance()
	get_parent().add_child(fire)
	fire.position = position
	self.queue_free()
