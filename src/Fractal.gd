# Fractal.gd
#---------------------------------
extends PanelContainer

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

@onready var m_fractalType: OptionButton = $"VBoxContainer/OptionButton"

@onready var m_octavesLabel: Label = $"VBoxContainer/Octaves/Label"
@onready var m_lacunarityLabel: Label = $"VBoxContainer/Lacunarity/Label"
@onready var m_gainLabel: Label = $"VBoxContainer/Gain/Label"
@onready var m_weightLabel: Label = $"VBoxContainer/Weight/Label"
@onready var m_pingpongLabel: Label = $"VBoxContainer/Pingpong/Label"

@onready var m_octaves: HSlider = $"VBoxContainer/Octaves/HSlider"
@onready var m_lacunarity: HSlider = $"VBoxContainer/Lacunarity/HSlider"
@onready var m_gain: HSlider = $"VBoxContainer/Gain/HSlider"
@onready var m_weight: HSlider = $"VBoxContainer/Weight/HSlider"
@onready var m_pingpong: HSlider = $"VBoxContainer/Pingpong/HSlider"

#---------------------------------
func _ready():
	# add items to optionBox
	m_fractalType.add_item('fractal none', FastNoiseLite.FractalType.FRACTAL_NONE)
	m_fractalType.add_item('fractal fbm', FastNoiseLite.FractalType.FRACTAL_FBM)
	m_fractalType.add_item('fractal ridged', FastNoiseLite.FractalType.FRACTAL_RIDGED)
	m_fractalType.add_item('fractal ping pong', FastNoiseLite.FractalType.FRACTAL_PING_PONG)
	
	m_fractalType.select(g_map.m_fractalType) # init optionBox to default value
	
	# init labels to default values
	m_octavesLabel.set_text('octaves: ' + str(g_map.m_fractalOctaves))
	m_lacunarityLabel.set_text('lacunarity: ' + str(g_map.m_fractalLacunarity))
	m_gainLabel.set_text('gain: ' + str(g_map.m_fractalGain))
	m_weightLabel.set_text('weight: ' + str(g_map.m_fractalWeightedStrength))
	m_pingpongLabel.set_text('pingpong: ' + str(g_map.m_fractalPingPongStrength))
	
	# init sliders to default values
	m_octaves.set_value(g_map.m_fractalOctaves)
	m_lacunarity.set_value(g_map.m_fractalLacunarity)
	m_gain.set_value(g_map.m_fractalGain)
	m_weight.set_value(g_map.m_fractalWeightedStrength)
	m_pingpong.set_value(g_map.m_fractalPingPongStrength)

#---------------------------------
func _on_fractalType_item_selected(index):
	g_map.m_fractalType = index
	g_map.generateWorld()

#---------------------------------
func _on_octave_value_changed(value):
	g_map.m_fractalOctaves = value
	m_octavesLabel.set_text('octaves: ' + str(g_map.m_fractalOctaves))
	g_map.generateWorld()

#---------------------------------
func _on_lacunarity_value_changed(value):
	g_map.m_fractalLacunarity = value
	m_lacunarityLabel.set_text('lacunarity: ' + str(g_map.m_fractalLacunarity))
	g_map.generateWorld()

#---------------------------------
func _on_gain_value_changed(value):
	g_map.m_fractalGain = value
	m_gainLabel.set_text('gain: ' + str(g_map.m_fractalGain))
	g_map.generateWorld()

#---------------------------------
func _on_weight_value_changed(value):
	g_map.m_fractalWeightedStrength = value
	m_weightLabel.set_text('weight: ' + str(g_map.m_fractalWeightedStrength))
	g_map.generateWorld()

#---------------------------------
func _on_pingpong_value_changed(value):
	g_map.m_fractalPingPongStrength = value
	m_pingpongLabel.set_text('pingpong: ' + str(g_map.m_fractalPingPongStrength))
	g_map.generateWorld()
