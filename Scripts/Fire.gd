extends Area2D

export var rot = Vector2()
export var velocity = Vector2()

func _ready():
	pass

func _process(delta):
	if velocity.length() > 0: 
        velocity = velocity.normalized() * 500 
	position += (velocity*delta)
	
func _on_Visibility_screen_exited():
	queue_free()