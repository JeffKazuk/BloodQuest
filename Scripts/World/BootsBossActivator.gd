extends Area2D

func _on_BootsBossActivator_body_entered(body):
	get_parent().get_node('Camera2D').target_name = 'BootsBossCamera'
	get_parent().get_node('Camera2D').zoom.x = 2
	get_parent().get_node('Camera2D').zoom.y = 2



func _on_BootsBossActivator_body_exited(body):
	get_parent().get_node('Camera2D').target_name = 'Player'
	get_parent().get_node('Camera2D').zoom.x = 1
	get_parent().get_node('Camera2D').zoom.y = 1
