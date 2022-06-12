extends KinematicBody2D

var fileName = "user://save_game.save"

export (int) var speed = 200
export (int) var select = 0
var velocity = Vector2()
var textScore = null
var bestScore = null
var lastScore = null
var score = 0
var move = 0
var gameOverButton
var coinSound
var swipe_start = null
var swipe_end = null


func _ready():
	randomize()
	select = round(rand_range(0,1))
	if select == 0:
		$Player2.hide()
	elif select == 1:
		$Player1.hide()

	textScore = get_parent().get_node("UI/Text/Score")
	bestScore = get_parent().get_node("UI/Text/BestScore")
	lastScore = get_parent().get_node("UI/Text/LastScore")
	coinSound = get_parent().get_node("CoinSound")
	gameOverButton = get_parent().get_node("UI/ButtonGameOver")
	gameOverButton.hide()
	
	bestScore.text = "Best Score\n" + "0" + loadData("best_score")
	lastScore.text = "Last Score\n" + "0" + loadData("last_score")
	

func _physics_process(delta):
	velocity = Vector2()
	if position.x < 13 or position.x > 348:
		move = 0
	
	if Input.is_action_pressed("ui_right"):
		if position.x > 348:
			move = 0
		else:
			move = 1
	elif Input.is_action_pressed("ui_left"):
		if position.x < 13:
			move = 0
		else:
			move = -1
			
	move()


func game_over():
	gameOverButton.show()
	get_tree().paused = true
	queue_free()
	save()
	
func get_coin():
	coinSound.play()
	score += 1
	if score <= 9:
		textScore.text = "0" + str(score)
	else:
		textScore.text = str(score)
	
func loadData(param):
	var get = File.new()
	get.open(fileName, File.READ)
	var result = get.get_var()
	get.close()
	return result[param]
	
func save():
	var bestScore = loadData("best_score")
	if score > int(bestScore):
		bestScore = score
	var file = File.new()
	file.open(fileName, File.WRITE)
	var content = {
		"best_score": str(bestScore),
		"last_score": str(score)
	}
	file.store_var(content)
	file.close()

func move():
	velocity.x += move
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)


func _on_Kanan_pressed():
	if position.x > 348:
		move = 0
	else:
		move = 1
	move()

func _on_Kiri_pressed():
	if position.x < 13:
		move = 0
	else:
		move = -1
	move()
