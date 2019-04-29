extends Area2D

signal win

func _ready():
	var player = get_parent().get_node('Player')
	player.connect('stick_gold_picked_up', self, '_on_Player_gold_stick_picked_up')
	self.connect('body_entered', player, '_on_World_Gold_Stick_body_entered')

func _on_Player_gold_stick_picked_up():
	hide()
    $CollisionShape2D.call_deferred('set_disabled', true)
    emit_signal('win')
