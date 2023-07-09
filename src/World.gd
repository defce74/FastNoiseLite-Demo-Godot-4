# World.gd
#---------------------------------
extends Node2D

#---------------------------------
func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("esc"): # esc: quit game
			get_tree().quit()

#---------------------------------
