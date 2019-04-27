extends KinematicBody2D

export var speed = 400  # How fast the player will move (pixels/sec).

var has_stick = false
var has_sword = false
var has_fire = false
var has_dagger = false

signal stick_picked_up
signal sword_picked_up
signal fire_picked_up
signal dagger_picked_up

func _ready():
    #position.x = 400
    #position.y = 400
	pass
func update_direction():
    #Gets the location of the mouse in radians
    var angle = get_global_mouse_position().angle_to_point(get_position())
    #print(get_global_mouse_position())
    #print(get_position())
    #Changes the looking direction of the character to roughly
    #where the mouse is
    #print(angle)
    if angle > PI/8 && angle < 3*PI/8:
        $AnimatedSprite.animation = 'SE'
    if angle > 3*PI/8 && angle < 5*PI/8:
        $AnimatedSprite.animation = 'S'
    if angle > 5*PI/8 && angle < 7*PI/8:
        $AnimatedSprite.animation = 'SW'
    if angle > 7*PI/8 && angle < PI:
        $AnimatedSprite.animation = 'W'
    if angle > -PI/8 && angle < PI/8:
        $AnimatedSprite.animation = 'E'
    if angle > -3*PI/8 && angle < -PI/8:
        $AnimatedSprite.animation = 'NE'
    if angle > -5*PI/8 && angle < -3*PI/8:
        $AnimatedSprite.animation = 'N'
    if angle > -7*PI/8 && angle < -5*PI/8:
        $AnimatedSprite.animation = 'NW'
    if angle > -PI && angle < -7*PI/8:
        $AnimatedSprite.animation = 'W'
    



func pickup_stick():
    has_stick = true

func pickup_sword():
    has_sword = true
    emit sword_picked_up

func pickup_fire():
    has_fire = true

func pickup_dagger():
    has_dagger = true

func _process(delta):
    var velocity = Vector2()  # The player's movement vector.
    update_direction()
    if Input.is_action_pressed("right"):
        velocity.x += 1
    if Input.is_action_pressed("left"):
        velocity.x -= 1
    if Input.is_action_pressed("down"):
        velocity.y += 1
    if Input.is_action_pressed("up"):
        velocity.y -= 1
    if velocity.length() > 0: #if the length of the vector is greater than 0
        velocity = velocity.normalized() * speed #sets the player's velocity
    move_and_collide(velocity*delta)# * delta #moves the player
    