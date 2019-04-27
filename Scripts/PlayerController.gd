extends Area2D

export var speed = 400  # How fast the player will move (pixels/sec).

#function thats called every delta second
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
    if velocity.length() > 0: #if the length of the vector is greater than 0
        velocity = velocity.normalized() * speed #sets the player's velocity
    position += velocity * delta #moves the player