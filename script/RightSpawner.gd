extends Timer

var cube = preload("res://assets/Obstacle.tscn") 
var coin1 = preload("res://assets/Coin1.tscn")
var coin2 = preload("res://assets/Coin2.tscn")
var coin_list = [coin1,coin2]
var _timer = null
var x_pos_obstacle = [200,150,85]
var x_pos_coin = [80,30,-35]

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(2)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _on_Timer_timeout():
	randomize()
	var random_value = round(rand_range(0,2))
	var random_coin = round(rand_range(0,1))
	var nodeInstanceCube = cube.instance()
	var nodeInstanceCoin = coin_list[random_coin].instance()
	nodeInstanceCube.position = Vector2(x_pos_obstacle[random_value],0)
	nodeInstanceCoin.position = Vector2(x_pos_coin[random_value],0)
	get_parent().add_child(nodeInstanceCube)
	get_parent().add_child(nodeInstanceCoin)



