# Gui.gd
#---------------------------------
extends Control

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

@onready var m_seedLabel: Label = $"VBoxContainer/Noise/Seed/Label"
@onready var m_freqLabel: Label = $"VBoxContainer/Noise/Frequency/Label"

@onready var m_fracOctLabel: Label = $"VBoxContainer/Fractals/FractalOctaves/Label"
@onready var m_fracLacLabel: Label = $"VBoxContainer/Fractals/FractalLacunarity/Label"

#---------------------------------
func _on_generate_map_pressed():
	g_map.generateWorld()

#---------------------------------
func _on_seed_slider_value_changed(value):
	g_map.m_seed = value
	m_seedLabel.set_text('seed: ' + str(g_map.m_seed))
	g_map.generateWorld()

#---------------------------------
func _on_freq_slider_value_changed(value):
	g_map.m_freq = value
	m_freqLabel.set_text('freq: ' + str(g_map.m_freq))
	g_map.generateWorld()

#---------------------------------
func _on_fracOct_slider_value_changed(value):
	g_map.m_fractalOctaves = value
	m_fracOctLabel.set_text('fractal octaves: ' + str(g_map.m_fractalOctaves))
	g_map.generateWorld()

#---------------------------------
func _on_fracLac_slider_value_changed(value):
	g_map.m_fractalLacunarity = value
	m_fracLacLabel.set_text('fractal octaves: ' + str(g_map.m_fractalLacunarity))
	g_map.generateWorld()
