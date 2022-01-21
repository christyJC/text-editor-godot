"""
File Editor Settings
Author: Jake Christy
Desc: Sets up a TextEdit node for porgamming
"""
extends TextEdit

func _ready():
	self.syntax_highlighting = true
	self.show_line_numbers = true
	self.size_flags_horizontal = SIZE_EXPAND_FILL
	self.size_flags_vertical = SIZE_EXPAND_FILL


func c_syntax():
	pass

func java_syntax():
	pass

func python_syntax():
	pass

# set color for all items in list
func keyword_color(keyword_list,color):
	pass

# set color of "strings"
func string_color(color):
	pass

# set color of char 'a'
func char_color(color):
	pass

# set color of functions foo()
func func_color(color):
	pass
	
# set color of numbers 124
func number_color(color):
	pass

# set color of comments //,/*,*/
func comment_color(single,start_block,end_block,color):
	pass
