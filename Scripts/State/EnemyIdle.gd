extends State

class_name EnemyIdle

# vars added for PhysicsUpdate()
# this is a refernce to enemy we are updating
@export var enemy : CharacterBody2D
# and move speed we are updating to
@export var move_speed := 10.0
# then in PhysicsUpdate()... (refer back down to PhysicsUpdate func)


#inside this state (the EnemyIdle state) we have the 2 variables below
var move_dir : Vector2
var wander_time : float

# also have a function to randomize these variables
func randomize_wander():
	move_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)


# and then when we Enter() this state (EnemyIdle state), we call the randomizer func
func Enter():
	randomize_wander()

func Update(delta : float):
	# in the Update func
	
	# we check if the wander_time is greater than 0
	if wander_time > 0:
		# if true, we tick it down using delta
		wander_time -= delta
	
	# otherwise, call randomizer func again and randomize the variables again
	else: 
		randomize_wander()


# for PhysicsUpdate() -> adding 2 more vars; refer to top
func PhysicsUpdate(_delta : float):
	# check if enemy exists:
	if enemy:
		# if it does exist: set velocity...
		enemy.velocity = move_dir * move_speed
		
	# this makes sense, becoz 'enemy' is an object of the CharacterBody2D class, which has 
	# class variable Velocity etc
	
