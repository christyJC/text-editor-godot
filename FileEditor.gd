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

	
func keyword_color(keyword_list,color):
	pass

func string_color(color):
	pass
	
func char_color(color):
	pass
	
func func_color(color):
	pass

func number_color(color):
	pass
