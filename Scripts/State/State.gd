extends Node

class_name State

# script will all the states

# following signal is use to move between states
signal Transitioned
# any time want to leave above state just call above signal


func Enter():
	pass
	
func Exit():
	
	pass
	

func Update(_delta: float):
	pass

func PhysicsUpdate(_delta : float):
	pass
	
