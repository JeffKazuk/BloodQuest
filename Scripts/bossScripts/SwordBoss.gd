extends KinematicBody2D


var speed = 1
var velocity = 0
var timer = 3
var angle_to_player
var player
var distance =0
var attack_timer = 80000
var sword
var Sword
signal hit_player

func _ready():
	set_physics_process(true)
	$Health.connect('health_depleted', self, 'dead')
	player = get_parent().find_node("Player")
	$Area2D.connect('area_entered', self, '_on_hit_by_fireball')
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
	$AnimatedSprite.animation = 'default'

func current_angle():
	angle_to_player = rad2deg(position.angle_to_point(player.position))
	#print(angle_to_player)
	return angle_to_player

func _on_hit_by_fireball(area):
	$Health.take_damage(7)
	$get_hit.play()
	print('gadersk')


func attack():
	print("Enemy is attacking")
	$swing_pivot.rotation = deg2rad(current_angle())-PI/2
	$swing_pivot.get_node('swing').animation = 'metal'
	$swing_pivot.get_node('swing').frame = 0
	$swing_pivot.show()
	$swing_pivot.get_node('swing').play()
	$sword_swing.play()
	if position.distance_to(player.global_position) < 150:
        emit_signal('hit_player')

func _get_hit(damage):
	print('yeowch')
	$get_hit.play()
	$Health.take_damage(damage)

func dead():
	get_parent().get_node('SwordBossActivator').spawnable = false
	Sword = preload('res://Scenes/World/World Sword.tscn')
	sword = Sword.instance()
	get_parent().add_child(sword)
	sword.position = position
	self.queue_free()

