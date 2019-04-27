extends KinematicBody2D

export var speed = 400  # How fast the player will move (pixels/sec).
export var direction = 0;

var weapons = []
var equipped = ''
var facing

signal stick_picked_up
signal sword_picked_up
signal fire_picked_up
signal dagger_picked_up

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

    $AnimatedSprite.animation = facing
    
#use _input for any inputs that need to be instant (mostly just mouse)
func _input(event):
    if event.is_action_pressed('click'):
        attack()
    if event.is_action_pressed('zoom_in'):
        print('prev weapon')
    if event.is_action_pressed('zoom_out'):
        print('next weapon')

#one function for all item pickups, will have to be changed a bit for other items
func pickup_item(item):
    weapons.append(item)
    emit_signal(item +'_picked_up')

func _on_World_Sword_body_entered(body):
    pickup_item('sword')
    
func attack():
    if equipped == 'sword':
        for node in get_tree().get_nodes_in_group('enemy'):
            if position.distance_to(node.position) < 70:
                
                var angle_to_enemy = rad2deg(direction.angle_to(node.direction))
                #print(direction)
                #print(node.direction)
                print(abs(angle_to_enemy))
                #I very clearly fucked this up but it works
                if abs(angle_to_enemy) < 202.5 && abs(angle_to_enemy) > 157.5:
                    print('hit enemy')


func _process(delta):
    # The player's movement vector.
    var velocity = Vector2()
    if Input.is_action_pressed("right"):
        velocity.x += 1
    if Input.is_action_pressed("left"):
        velocity.x -= 1
    if Input.is_action_pressed("down"):
        velocity.y += 1
    if Input.is_action_pressed("up"):
        velocity.y -= 1
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