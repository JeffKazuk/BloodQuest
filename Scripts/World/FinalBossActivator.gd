extends Area2D

var Boss
var boss
var Player
var audioMain
var audioFire
export var spawnable = true

func _ready():
    Boss = preload('res://Scenes/Bosses/finalBoss/finalBoss.tscn')
    boss = Boss.instance()
    Player = get_parent().find_node('Player')
    # audioMain = get_parent().find_node('AudioMain')
    # audioFire = get_parent().find_node('AudioFire')
    self.connect('body_entered', self, '_on_FinalBossActivator_body_entered')
    self.connect('body_exited', self, '_on_FinalBossActivator_body_exited')
    # self.connect('body_entered',audioMain,"boss")
    # self.connect('body_exited',audioMain,"notBoss")
    # self.connect('body_entered',audioFire,"boss")
    # self.connect('body_exited',audioFire,"notBoss")


func _on_FinalBossActivator_body_entered(body):
    if spawnable:
        get_parent().add_child(boss)
        boss.position = get_parent().get_node('FinalBossCamera').position
        boss.connect('mana', get_parent(), '_on_finalBoss_fire')
        Player.connect('hit_enemy', boss, '_get_hit')
    get_parent().get_node('Camera2D').target_name = 'FinalBossCamera'
    get_parent().get_node('Camera2D').zoom.x = 2.5
    get_parent().get_node('Camera2D').zoom.y = 2.5

func _on_FinalBossActivator_body_exited(body):
    #get_parent().remove_child(boss)
    if spawnable:
        get_parent().remove_child(boss)
    get_parent().get_node('Camera2D').target_name = 'Player'
    get_parent().get_node('Camera2D').zoom.x = 1.25
    get_parent().get_node('Camera2D').zoom.y = 1.25