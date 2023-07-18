# Menu.gd
#---------------------------------
extends PanelContainer

#---------------------------------
@onready var g_map: Map = get_tree().root.get_node("World").get_node("Map")

@onready var m_noise: FastNoise = $"../FastNoise"
@onready var m_cellular: Cellular = $"../Cellular"
@onready var m_domain: DomainWarp = $"../DomainWarp"
@onready var m_fractal: Fractal = $"../Fractal"

@onready var m_fileName: Label = $"VBoxContainer/FileName"

var m_openDialog: FileDialog = FileDialog.new()
var m_saveDialog: FileDialog = FileDialog.new()

const m_filePath: String = 'user://save/'

#---------------------------------
func _ready():
	set_filePath()
	
	m_fileName.set_text(g_map.m_data.m_fileName)
	
	add_child(m_openDialog)
	add_child(m_saveDialog)
	
	m_openDialog.add_filter('*.tres', 'MapData resource')
	m_saveDialog.add_filter('*.tres', 'MapData resource')
	
	m_openDialog.set_size(Vector2i(600, 400))
	m_saveDialog.set_size(Vector2i(600, 400))
	
	m_openDialog.set_position(Vector2i(300, 300))
	m_saveDialog.set_position(Vector2i(300, 300))

#---------------------------------
func set_filePath():
	if !(DirAccess.dir_exists_absolute(m_filePath)):
		DirAccess.make_dir_absolute(m_filePath)

	m_openDialog.set_access(FileDialog.ACCESS_USERDATA)
	m_saveDialog.set_access(FileDialog.ACCESS_USERDATA)
	
	m_openDialog.set_current_path(m_filePath)
	m_saveDialog.set_current_path(m_filePath)

#---------------------------------
func _on_open_pressed():
	m_openDialog.set_file_mode(FileDialog.FILE_MODE_OPEN_FILE)
	
	if !(m_openDialog.is_connected('file_selected', _on_open_file_selected)):
		m_openDialog.connect('file_selected', _on_open_file_selected)
		
	m_openDialog.show()

#---------------------------------
func _on_save_pressed():
	m_saveDialog.set_file_mode(FileDialog.FILE_MODE_SAVE_FILE)
	
	if !(m_saveDialog.is_connected('file_selected', _on_save_file_selected)):
		m_saveDialog.connect('file_selected', _on_save_file_selected)
	m_saveDialog.show()

#---------------------------------
func _on_open_file_selected(path):
	g_map.loadData(path)
	g_map.setScale()
	g_map.generateMap()
	m_fileName.set_text(g_map.m_data.m_fileName)
	
	m_noise.updateControls()
	m_cellular.updateControls()
	m_domain.updateControls()
	m_fractal.updateControls()

#---------------------------------
func _on_save_file_selected(path):
	g_map.saveData(path)
	m_fileName.set_text(g_map.m_data.m_fileName)

#---------------------------------
