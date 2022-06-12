extends Area2D

export (int) var speed = 200
var velocity = Vector2()

func _physics_process(delta):
	velocity.y = 1
	velocity = velocity.normalized() * speed
	position += velocity * delta
	if int(position.y) > 1000:
		queue_free()
	

# When obstacle collision with player
func _on_Obstacle_body_entered(body):
	body.game_over()

# When coin1 collision with player
func _on_Coin1_body_entered(body):
	if body.select == 1:
		body.game_over()
	else:
		body.get_coin()
		queue_free() 

# When coin2 collision with player
func _on_Coin2_body_entered(body):
	if body.select == 0:
		body.game_over()
	else:
		body.get_coin()
		queue_free() 
