extends Area2D

export var rot = Vector2()
export var velocity = Vector2()

func _ready():
	pass

func _process(delta):
	if velocity.length() > 0: #if the length of the vector is greater than 0
        velocity = velocity.normalized() * 500 #sets the player's velocity
	position += (velocity*delta)#moves the player
	
func _on_Visibility_screen_exited():
	queue_free()