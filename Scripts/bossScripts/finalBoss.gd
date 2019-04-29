extends KinematicBody2D


var speed = 4
var velocity=0
var timer = rand_range(1,3)
var angle_to_player = 0;
signal mana (Mana, rotation, position)
var player
var distance = 0
var teleport_timer = 5


func _ready():
    set_physics_process(true)
    player = get_parent().find_node("Player")
    $Health.connect('health_depleted', self, 'dead')
    $Area2D.connect('area_entered', self, '_on_hit_by_fireball')
    self.connect('mana', get_parent(), '_on_finalBoss_fire')
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

func teleport():
    $teleport.play()
    position.x  = rand_range(19300,20470)
    position.y = rand_range(14480,15670)

func _process(delta):
    timer -= delta
    teleport_timer -= delta
    if teleport_timer <= 0:
        teleport()
        teleport_timer = rand_range(0,5)
    if timer<=0:
        attack()
        timer = rand_range(0,.5)
    #print(rotation)
    
    var angle = velocity.angle()
    #print(angle)
    

    $AnimatedSprite.animation = 'default'

func _on_hit_by_fireball(area):
    $Health.take_damage(7)
    print('gadersk')

func _get_hit(damage):
	print('yeowch')
	$Health.take_damage(damage)

func current_angle():
    angle_to_player = rad2deg(position.angle_to_point(player.position))
    #print(angle_to_player)
    return angle_to_player

func attack():
    print("Enemy is attacking")
    var player = get_parent().find_node("Player")
    var Mana = preload('res://Scenes/Bosses/finalBoss/Mana.tscn')
    emit_signal('mana', Mana, velocity.angle(), position)

func dead():
	get_parent().get_node('FinalBossActivator').spawnable = false
	self.queue_free()