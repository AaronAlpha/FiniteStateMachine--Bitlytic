extends State

class_name EnemyFollow

# for PhysicsUpdates, adding reference to enemy and move_speed
@export var enemy : CharacterBody2D
@export var move_speed := 40.0


var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	
func PhysicsUpdate(_delta : float):
	# getting direction between player and enemy
	var direction = player.global_position - enemy.global_position
	
	# and if the direction is outside some distance
	if direction.length() > 25:
		# move the enemy toward the player
		enemy.velocity = direction.normalized() * move_speed
	else:
		# otherwise have it stand still
		enemy.velocity = Vector2()


	# Transitioning between states is state-dependent; 
	# following is transitioning from follow to idle
	# want follow state to go back to being idle once reached a certain threshold
	if direction.length() > 400:
		Transitioned.emit(self, "EnemyIdle")
		# above passes in 'self' (which is the current_state) and 'idle' (which is the new_state we want to 
		# Transition to)
