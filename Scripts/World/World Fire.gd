extends Area2D

func _ready():
	var player = get_parent().get_node('Player')
	player.connect('fire_picked_up', self, '_on_Player_fire_picked_up')
	self.connect('body_entered', player, '_on_World_Fire_body_entered')

func _on_Player_fire_picked_up():
	hide()
	$CollisionShape2D.call_deferred('set_disabled', true)
