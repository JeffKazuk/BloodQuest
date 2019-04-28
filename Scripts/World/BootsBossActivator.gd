extends Area2D

var Boss
var boss

func _ready():
	Boss = preload('res://Scenes/Bosses/bootsBoss/bootsBoss.tscn')
	boss = Boss.instance()
	
func _on_BootsBossActivator_body_entered(body):
	get_parent().add_child(boss)
	boss.connect('hit_player', get_parent().find_node('Player'), '_on_bootsBoss_hit_player')
	boss.position = get_parent().get_node('BootsBossCamera').position
	get_parent().get_node('Camera2D').target_name = 'BootsBossCamera'
	get_parent().get_node('Camera2D').zoom.x = 2
	get_parent().get_node('Camera2D').zoom.y = 2



func _on_BootsBossActivator_body_exited(body):
	get_parent().remove_child(boss)
	get_parent().get_node('Camera2D').target_name = 'Player'
	get_parent().get_node('Camera2D').zoom.x = 1
	get_parent().get_node('Camera2D').zoom.y = 1
