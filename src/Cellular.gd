# Cellular.gd
#---------------------------------
extends PanelContainer

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

@onready var m_returnType: OptionButton = $"VBoxContainer/ReturnType"
@onready var m_distanceFunction: OptionButton = $"VBoxContainer/DistanceFunction"

@onready var m_jitterLabel: Label = $"VBoxContainer/Jitter/Label"
@onready var m_jitter: HSlider = $"VBoxContainer/Jitter/HSlider"

#---------------------------------
func _ready():
	# add items to returnType optionButton
	m_returnType.add_item('cell value', FastNoiseLite.CellularReturnType.RETURN_CELL_VALUE)
	m_returnType.add_item('distance', FastNoiseLite.CellularReturnType.RETURN_DISTANCE)
	m_returnType.add_item('distance 2', FastNoiseLite.CellularReturnType.RETURN_DISTANCE2)
	m_returnType.add_item('distance 2 add', FastNoiseLite.CellularReturnType.RETURN_DISTANCE2_ADD)
	m_returnType.add_item('distance 2 sub', FastNoiseLite.CellularReturnType.RETURN_DISTANCE2_SUB)
	m_returnType.add_item('distance 2 mul', FastNoiseLite.CellularReturnType.RETURN_DISTANCE2_MUL)
	m_returnType.add_item('distance 2 div', FastNoiseLite.CellularReturnType.RETURN_DISTANCE2_DIV)
	
	# add items to distanceFunction optionButton
	m_distanceFunction.add_item('distance euclidean', FastNoiseLite.CellularDistanceFunction.DISTANCE_EUCLIDEAN)
	m_distanceFunction.add_item('distance euclidean squared', FastNoiseLite.CellularDistanceFunction.DISTANCE_EUCLIDEAN_SQUARED)
	m_distanceFunction.add_item('distance manhattan', FastNoiseLite.CellularDistanceFunction.DISTANCE_MANHATTAN)
	m_distanceFunction.add_item('distance hybrid', FastNoiseLite.CellularDistanceFunction.DISTANCE_HYBRID)
	
	# init optionButtons to default values
	m_returnType.select(g_map.m_cellularReturnType)
	m_returnType.select(g_map.m_cellularDistanceFunction)
	
	# init label and slider to default values
	m_jitterLabel.set_text('jitter: ' + str(g_map.m_cellularJitter))
	m_jitter.set_value(g_map.m_cellularJitter)

#---------------------------------
func _on_returnType_item_selected(index):
	g_map.m_cellularReturnType = index
	g_map.generateWorld()
	
#---------------------------------
func _on_distanceFunction_item_selected(index):
	g_map.m_cellularJitter = index
	g_map.generateWorld()

#---------------------------------
func _on_jitter_value_changed(value):
	g_map.m_cellularJitter = value
	m_jitterLabel.set_text('jitter: ' + str(g_map.m_cellularJitter))
	g_map.generateWorld()

