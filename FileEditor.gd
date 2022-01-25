"""
File Editor Settings
Author: Jake Christy
Desc: Sets up a TextEdit node for programming
"""
extends TextEdit

# TODO: finish adding keywords for each language
var default_color_map = {
		"keyword" : Color.aqua,
		"string" : Color.coral,
		"char" : Color.forestgreen,
		"func" : Color.aquamarine,
		"number" : Color.magenta,
		"comment" : Color.darkgray
}

var _file_path = ""

func _ready():
	self.syntax_highlighting = true
	self.show_line_numbers = true
	self.size_flags_horizontal = SIZE_EXPAND_FILL
	self.size_flags_vertical = SIZE_EXPAND_FILL
	self.minimap_draw = true
	
	
func get_file_path():
	return _file_path

func set_file_path(path):
	_file_path = path
	
	
	
func c_default():
	c_syntax(default_color_map)

func c_syntax(color_map):
	var keyword_list = ['int','long','float','double','struct','typedef','static']
	keywords_color(keyword_list,color_map["keyword"])
	
	comment_color('//','/*','*/',color_map["comment"])
	
	string_color(color_map["string"])
	char_color(color_map["char"])
	func_color(color_map["func"])
	number_color(color_map["number"])
	
func java_default():
	java_syntax(default_color_map)

func java_syntax(color_map):
	var keyword_list = ['int','long','float','double','public','private','protected','class','static','enum']
	keywords_color(keyword_list,color_map["keyword"])
	var class_list = ['class','this','super','new','abstract','interface','implements']
	keywords_color(class_list,color_map["keyword"])
	var condition_list = ['if','else','for','while','try','throw','throws','finally','true','false','null',
	'switch','case','default','break','continue']
	keywords_color(condition_list,color_map["keyword"])
	
	comment_color('//','/*','*/',color_map["comment"])
	
	string_color(color_map["string"])
	char_color(color_map["char"])
	func_color(color_map["func"])
	number_color(color_map["number"])
	
func python_default():
	python_syntax(default_color_map)

func python_syntax(color_map):
	var keyword_list = ['def','class','import','from','as','None','del',
	'global','nonlocal','lambda','yeild']
	keywords_color(keyword_list,color_map["keyword"])
	
	var condition_list = ['True','False','if','elif','else',
	'is','and','not','in','break','continue','pass','for','while','assert',
	'try','raise','except','finally']
	keywords_color(condition_list,color_map["keyword"])
	
	keywords_color(keyword_list,color_map["keyword"])
	comment_color('#','"""','"""',color_map["comment"])
	string_color(color_map["string"])
	char_color(color_map["char"])
	func_color(color_map["func"])
	number_color(color_map["number"])

# set color for all items in list
func keywords_color(keyword_list,color):
	for keyword in keyword_list:
		self.add_keyword_color(keyword,color)

# set color of "strings"
func string_color(color):
	self.add_color_region('"','"',color)

# set color of char 'a'
func char_color(color):
	self.add_color_region('\'','\'',color)

# set color of functions foo()
func func_color(color):
	self.add_color_override("function_color",color)
	
# set color of numbers 124
func number_color(color):
	self.add_color_override("number_color",color)

# set color of comments //,/*,*/
func comment_color(start_single,start_block,end_block,color):
	self.add_color_region(start_single,'',color,true)
	self.add_color_region(start_block,end_block,color,true)
