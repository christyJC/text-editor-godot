extends TabContainer



func _ready():
	pass

# Tab control functions 
# add a TextEdit node to tab container
func new_tab(container,tab):
	var editor_count = container.get_child_count()
	
	tab.name = "Untitled" + str(editor_count) # rename tab
	container.add_child(tab)
	container.current_tab = editor_count # set current tab to last tab
	tab.grab_focus() #put cursor in editor
	print("ok")
	

# remove TextEdit node from tab container
# ask to save changes before closing
func close_tab(container):
	if tabs_exist(container):
		var curr_tab = container.current_tab
		var to_be_closed = container.get_child(curr_tab) # get the text editor to be closed
		to_be_closed.queue_free() # remove text editor
		# TODO: warn before closing if there is text

# cycle active TextEdit to the right
func next_tab(container):
	if tabs_exist(container):
		var curr_tab = container.current_tab
		var last_tab = container.get_tab_count() - 1
		
		if curr_tab == last_tab: # check for wrapping
			container.current_tab = 0
		else:
			container.current_tab = curr_tab + 1 # move right

# cycle active TextEdit to the left
func prev_tab(container):
	if tabs_exist(container):
		var first_tab = 0
		var curr_tab = container.current_tab
		var last_tab = container.get_tab_count() -1
		
		if curr_tab ==  first_tab: # check for wrapping
			container.current_tab = last_tab
		else:
			container.current_tab = curr_tab - 1 # move left

# check that at least one tab exists
func tabs_exist(container):
	if container.get_tab_count() > 0:
		return true
	else:
		return false 
