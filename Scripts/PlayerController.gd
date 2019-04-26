extends Area2D

export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.

func _ready():
    screen_size = get_viewport_rect().size

func _process(delta):
    var velocity = Vector2()  # The player's movement vector.
    if Input.is_action_pressed("right"):
        velocity.x += 100
    if Input.is_action_pressed("left"):
        velocity.x -= 100
    if Input.is_action_pressed("down"):
        velocity.y += 100
    if Input.is_action_pressed("up"):
        velocity.y -= 100
    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
    position += velocity * delta