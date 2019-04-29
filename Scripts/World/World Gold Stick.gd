extends Area2D

signal win
var player
var camera
var podium


func _ready():
    camera = get_parent().get_node('Camera2D')
    player = get_parent().get_node('Player')
    podium = get_parent().get_node('stick_podium')
    player.connect('gold_stick_picked_up', self, '_on_Player_gold_stick_picked_up')
    self.connect('body_entered', player, '_on_World_Gold_Stick_body_entered')
    
func _process(delta):
    camera.target_name = 'stick_podium'
    camera.zoom.x = podium.position.distance_to(player.position)
    camera.zoom.y = podium.position.distance_to(player.position)

func _on_Player_gold_stick_picked_up():
    hide()
    $CollisionShape2D.call_deferred('set_disabled', true)
    emit_signal('win')
