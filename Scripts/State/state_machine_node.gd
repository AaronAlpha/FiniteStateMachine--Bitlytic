extends Node

# last thing: adding an exported variable
@export var initial_state : State # thought continued on line 28

# idea: to have State Machine in that scene tree and ao that every state is a child of that 
# node(i believe the FSM)

var current_state : State
var states : Dictionary = {}

# NOTE: to_lower() is used to avoid capitalization maessing up

func _ready():
	# looping over all of the children
	for child in get_children():
		# if child is a state:
		if child is State:
			# add state to Dictionary using the state's name
			states[child.name.to_lower()] = child
			
			# anytime a new state is registered, can just connect 'Transition' signal 
			# this will connect to a fuinction: 'on_child_transition'
			child.Transitioned.connect(on_child_transition)
	
	# where we define the initial_state we want the state-machine to be in
	# checking if intiial_state exists
	if initial_state:
		initial_state.Enter()
		current_state = initial_state

func _process(delta: float) -> void:
	# checking if there is a current_state
	if current_state:
		current_state.Update(delta)

func _physics_process(delta : float) -> void:
	# checking if there is a current_state
	if current_state:
		current_state.PhysicsUpdate(delta)


func on_child_transition(state, new_state_name):
	# this function takes in the state that called it and the new_state_name it wants to transition to 
	
	# checking if the state that called this function is not the current_state
	if state != current_state:
		return 
	
	# grabbing new_state from state_dictionary
	var new_state = states.get(new_state_name.to_lower())
	# checking if that state exists
	if !new_state:
		return
	
	# check if we have a current state:
	if current_state:
		current_state.exit() # exitiing the current state
	# and enter into new state
	new_state.enter()
	# and make the new_state the current_state
	current_state = new_state
	
	
	
	
	
	# NOW WE CAN BUILD OUR STATES
	
	
