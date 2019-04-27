extends Area2D


func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_Player_sword_picked_up():
	hide()
	$CollisionShape2D.call_deferred('set_disabled', true)
