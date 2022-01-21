extends Control


func _ready():
	pass

func _process(delta):
	pass
	
# Tab control functions 
# add a TextEdit node to tab container
func new_tab():
	pass

# remove TextEdit node from tab container
# ask to save changes before closing
func close_tab():
	pass

# cycle active TextEdit to the right
func next_tab():
	pass

# cycle active TextEdit to the left
func prev_tab():
	pass
	
# File control functions
# show a file dialog, then put text into current TextEdit
func open_file():
	pass

# save changes to current file
func save_file():
	pass


# Preferences menu 
# open a preferences menu
func pref_menu():
	pass

# save updated preferences
func pref_save():
	pass

# restore preferences to defaults 
func pref_restore():
	pass
