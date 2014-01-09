--- Définition de différentes variables globales concernant notamment
--l'écran et l'apparence du jeu
module 'design/defs'

width = 640
height = 480
fullscreen = false

CellStyle = {
	{color = {255,255,255}, mode = 'line'}
}

PathStyle = {
	{color = {100, 100, 100}, mode = 'fill'}
}

PanelStyle = {
	{color = {0, 0, 0},       mode = 'fill'}
}

BasicTowerStyle = {
	{color = {192, 192, 192}, mode = 'fill'}
}

BeamTowerStyle = {
	{color = {192,192,192}, mode = 'fill'}
}

RangeStyle = {
	{color = {64, 64, 255, 32}, mode = 'fill'}
}

SplashTowerStyle = {
	{color = {192, 192, 192}, mode = 'fill'},
}

FreezeTowerStyle = {
	{color = {192, 192, 192}, mode = 'fill'},
}

SlowTowerStyle = {
	{color = {192, 192, 192}, mode = 'fill'},
}
