extends TabContainer



func _ready():
	pass

func editor_focus():
	self.get_child(self.current_tab).grab_focus()

# Tab control functions 
# add a TextEdit node to tab container
func new_tab(tab):
	var editor_count = self.get_child_count()
	
	tab.name = "Untitled" + str(editor_count) # rename tab
	self.add_child(tab)
	self.current_tab = editor_count # set current tab to last tab
	editor_focus()
	

# remove TextEdit node from tab container
# ask to save changes before closing
func close_tab():
	if tabs_exist():
		var curr_tab = self.current_tab
		var to_be_closed = self.get_child(curr_tab) # get the text editor to be closed
		to_be_closed.queue_free() # remove text editor
		# TODO: warn before closing if there is text

# cycle active TextEdit to the right
func next_tab():
	if tabs_exist():
		var curr_tab = self.current_tab
		var last_tab = self.get_tab_count() - 1
		
		if curr_tab == last_tab: # check for wrapping
			self.current_tab = 0
		else:
			self.current_tab = curr_tab + 1 # move right
		editor_focus()
		

# cycle active TextEdit to the left
func prev_tab():
	if tabs_exist():
		var first_tab = 0
		var curr_tab = self.current_tab
		var last_tab = self.get_tab_count() -1
		
		if curr_tab ==  first_tab: # check for wrapping
			self.current_tab = last_tab
		else:
			self.current_tab = curr_tab - 1 # move left
		editor_focus()
		
# check that at least one tab exists
func tabs_exist():
	return self.get_tab_count() > 0
	
