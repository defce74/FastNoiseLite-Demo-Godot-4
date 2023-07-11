# Map.gd
#---------------------------------
class_name Map extends TileMap

#---------------------------------
# tiles
var m_water = Vector2i(2, 0)
var m_grass = Vector2i(4, 2)

# map dimensions
var m_mapSize: Vector2 = Vector2(512, 512)

# random noise generator
var m_noise = FastNoiseLite.new()

# FastNoiseLite variables
var m_noiseType: FastNoiseLite.NoiseType = FastNoiseLite.NoiseType.TYPE_SIMPLEX
var m_seed: int = 1337
var m_freq: float = 0.01
var m_fractalType: FastNoiseLite.FractalType = FastNoiseLite.FractalType.FRACTAL_NONE
var m_fractalOctaves: int = 2
var m_fractalLacunarity: float = 2.0
var m_fractalGain: float = 0.5
var m_fractalWeightedStrength: float = 0.0 
var m_fractalPingPongStrength: float = 2.0

#---------------------------------
func _ready():
	setScale()
	generateWorld()

#---------------------------------
func setScale():
	var viewport: Vector2 = get_viewport_rect().size
	var tileSize: Vector2 = get_tileset().get_tile_size()
	var pixels = tileSize * m_mapSize
	
	set_scale(viewport / pixels)

#---------------------------------
func generateWorld():
	var m_tileList = []
	m_tileList.append(m_water)
	m_tileList.append(m_grass)
	
	m_noise.set_noise_type(m_noiseType)
	m_noise.set_seed(m_seed) # randi_range(0, 500)
	m_noise.set_frequency(m_freq)
	m_noise.set_fractal_type(m_fractalType)
	m_noise.set_fractal_octaves(m_fractalOctaves) # number of octaves to generate - 1 octave per tile
	m_noise.set_fractal_lacunarity(m_fractalLacunarity)
	m_noise.set_fractal_gain(m_fractalGain)
	m_noise.set_fractal_weighted_strength(m_fractalWeightedStrength) # keep between 0 to 1
	m_noise.set_fractal_ping_pong_strength(m_fractalPingPongStrength)
	
	for x in range(m_mapSize.x):
		for y in range(m_mapSize.y):
			var absNoise: float = abs(m_noise.get_noise_2d(x, y)) # get float value between -1 and 1
			var tileToPlace: int = floori(absNoise * m_tileList.size()) # get tile the noise value corresponds to
			
			set_cell(0, Vector2i(x,y), 0, m_tileList[tileToPlace])

#---------------------------------
