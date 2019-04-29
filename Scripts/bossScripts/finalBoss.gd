extends KinematicBody2D


var speed = 2
var velocity=0
var timer = rand_range(1,3)
var angle_to_player = 0;
signal mana (Mana, rotation, position)
var player
var distance = 0
var teleport_timer = 5
export var teleport_x
export var teleport_y

func _ready():
    set_physics_process(true)
    player = get_parent().find_node("Player")
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

func _process(delta):
    timer -= delta
    teleport_timer -= delta
    if teleport_timer <= 0:
        teleport()
    if timer<=0:
        attack()
        timer = rand_range(0,3)
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
    var Mana = preload('res://Scenes/Bosses/finalBoss/Mana.tscn')
    emit_signal('mana', Mana, velocity.angle(), position)

