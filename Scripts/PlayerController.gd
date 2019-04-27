extends KinematicBody2D

export var speed = 400  # How fast the player will move (pixels/sec).
export var direction = 0;

var weapons = ['sword', 'stick', 'fire']
var equipped = ''
var facing
var velocity
var dash_timer = 0
var frame_timer = 0
var fire_timer = 0

signal stick_picked_up
signal sword_picked_up
signal fire_picked_up
signal dagger_picked_up
signal fire(Fire, rotation, position)

func _ready():
    #position.x = 400
    #position.y = 400
    pass

func current_angle():
    return get_global_mouse_position().angle_to_point(get_position())
    
func update_direction():
    #Gets the location of the mouse in radians
    var angle = current_angle()
    #print(get_global_mouse_position())
    #print(get_position())
    #Changes the looking direction of the character to roughly
    #where the mouse is
    #print(angle)
    if angle > PI/8 && angle < 3*PI/8:
        facing = '315'
    if angle > 3*PI/8 && angle < 5*PI/8:
        facing = '270'
    if angle > 5*PI/8 && angle < 7*PI/8:
        facing = '225'
    if angle > 7*PI/8 && angle < PI:
        facing = '180'
    if angle > -PI/8 && angle < PI/8:
        facing = '0'
    if angle > -3*PI/8 && angle < -PI/8:
        facing = '45'
    if angle > -5*PI/8 && angle < -3*PI/8:
        facing = '90'
    if angle > -7*PI/8 && angle < -5*PI/8:
        facing = '135'
    if angle > -PI && angle < -7*PI/8:
        facing = '180'
    #print(facing)
    $AnimatedSprite.animation = facing
    
#use _input for any inputs that need to be instant (mostly just mouse)
func _input(event):
    if event.is_action_pressed('click'):
        attack(event.position)
    if event.is_action_pressed('zoom_in'):
        if len(weapons) >= 2:
            var prev_item = weapons.find(equipped)-1
            if prev_item < 0:
                prev_item = len(weapons)-1
            equipped = weapons[prev_item]
        print(equipped)
            
    if event.is_action_pressed('zoom_out'):
        if len(weapons) >= 2:
            var next_item = weapons.find(equipped)+1
            if next_item > len(weapons)-1:
                next_item = 0
            equipped = weapons[next_item]
        print(equipped)

#one function for all item pickups, will have to be changed a bit for other items
func pickup_item(item):
    weapons.append(item)
    if len(weapons) == 1:
        equipped = item
    emit_signal(item +'_picked_up')

func _on_World_Sword_body_entered(body):
    pickup_item('sword')
    $Health.take_damage(30)
    
func _on_World_Stick_body_entered(body):
    pickup_item('stick')
    $Health.take_damage(5)

func _on_World_Fire_body_entered(body):
    pickup_item('fire')
    $Health.take_damage(20)

func _on_World_Dagger_body_entered(body):
    pickup_item('dagger')
    $Health.take_damage(10)

func dash():
    var angle = current_angle()
    var rot
    frame_timer = 5
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
    velocity.x = cos(rot)
    velocity.y = sin(rot)
    speed *= 10

func attack(spot):
    # print(spot)
    if equipped == 'stick':
        for node in get_tree().get_nodes_in_group('enemy'):
            if position.distance_to(node.position) < 150:
                
                var angle_to_enemy = rad2deg(direction.angle_to(node.velocity))
                #print(direction)
                #print(node.direction)
                print(abs(angle_to_enemy))
                #I very clearly fucked this up but it works
                if abs(angle_to_enemy) < 202.5 && abs(angle_to_enemy) > 157.5:
                    print('hit enemy')

    if equipped == 'sword':
        for node in get_tree().get_nodes_in_group('enemy'):
            if position.distance_to(node.position) < 150:
                
                var angle_to_enemy = rad2deg(direction.angle_to(node.velocity))
                #print(direction)
                #print(node.direction)
                print(abs(angle_to_enemy))
                #I very clearly fucked this up but it works
                if abs(angle_to_enemy) < 202.5 && abs(angle_to_enemy) > 157.5:
                    print('hit enemy')

    if equipped == 'dagger':
        for node in get_tree().get_nodes_in_group('enemy'):
            if position.distance_to(node.position) < 40:
                var direction = (get_global_mouse_position()-position).normalized()
                var angle_to_enemy = rad2deg(direction.angle_to(node.velocity))
                    #print(direction)
                    #print(node.direction)
                print(abs(angle_to_enemy))
                    #I very clearly fucked this up but it works
                if abs(angle_to_enemy) < 202.5 && abs(angle_to_enemy) > 157.5:
                    print('hit')

    if equipped == 'fire':
        if fire_timer <= 0:
            var Fire = preload('res://Scenes/Player/Fire.tscn')
            emit_signal('fire', Fire, current_angle(), position)
            fire_timer = 0.5
        #print(deg2rad(float(facing)))

func _process(delta):
    # The player's movement vector.
    velocity = Vector2()
    dash_timer -= delta
    fire_timer -= delta
    if Input.is_action_pressed("right"):
        velocity.x += 1
    if Input.is_action_pressed("left"):
        velocity.x -= 1
    if Input.is_action_pressed("down"):
        velocity.y += 1
    if Input.is_action_pressed("up"):
        velocity.y -= 1
    if Input.is_action_pressed('dash'):
        if dash_timer <= 0:
            dash()
            dash_timer = 1
    if Input.is_action_pressed('one'):
        if len(weapons) >= 1:
            equipped = weapons[0]
    if Input.is_action_pressed('two'):
        if len(weapons) >= 2:
            equipped = weapons[1]
    if Input.is_action_pressed('three'):
        if len(weapons) >= 3:
            equipped = weapons[2]
    if Input.is_action_pressed('four'):
        if len(weapons) >= 4:
            equipped = weapons[3]
    update_direction()
    direction = (get_global_mouse_position()-position).normalized()
    #print(equipped)

    if velocity.length() > 0: #if the length of the vector is greater than 0
        velocity = velocity.normalized() * speed #sets the player's velocity
    move_and_collide(velocity*delta)#moves the player
    frame_timer -= 1
    if frame_timer <= 0:
        speed = 400

#detect and take damage from fireballs
func _on_Hitbox_area_entered(area):
	$Health.take_damage(10)
