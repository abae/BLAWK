/// @function nineSlice(sprite, x, y, width, height, stretched)
/// @arg sprite
/// @arg x
/// @arg y
/// @arg width
/// @arg height
/// @arg stretched

// Initialize variables
var _sprite, _x, _y, _width, _height, _stretched;
var _snapWidth, _snapHeight, _spriteWidth, _spriteHeight, _tileWidth, _tileHeight;

// Define arguments
_sprite = argument0;     // Choose the panel sprite
_x = argument1;          // x coordinate for the top left corner 
_y = argument2;          // y coordinate for the top left corner
_width = argument3;      // Width of the panel
_height = argument4;     // Height of the panel
_stretched = argument5;  // Stretch the panel (true) or tile (false)

// Calculate sprite width and height
_spriteWidth = sprite_get_width(_sprite);
_spriteHeight = sprite_get_height(_sprite);

// If not stretched, calculate number of sprite repetitions
if (!_stretched) {
	_width += _width mod _spriteWidth;
	_height += _height mod _spriteHeight;
	
	_tileWidth = ((_width - _spriteWidth * 2) / _spriteWidth);
	_tileHeight = ((_height - _spriteHeight * 2) / _spriteHeight);
}

// Top Left
draw_sprite(_sprite, 0, _x, _y);

// Top Center
if (_stretched) {
	draw_sprite_stretched(_sprite, 1, _x + _spriteWidth, _y, _width - _spriteWidth*2, _spriteHeight);
} else {
	for (var _xPos = 1; _xPos <= _tileWidth; _xPos++) {
		draw_sprite(_sprite, 1, _x + (_xPos * _spriteWidth), _y);	
	}
}

// Top Right
draw_sprite(_sprite, 2, _x + _width - _spriteWidth, _y);

// Middle Left
if (_stretched) {
	draw_sprite_stretched(_sprite, 3, _x, _y + _spriteHeight, _spriteWidth, _height - _spriteHeight*2);
} else {
	for (var _yPos = 1; _yPos <= _tileHeight; _yPos++) {
		draw_sprite(_sprite, 3, _x, _y + (_yPos * _spriteHeight));	
	}
}

// Middle Center
if (_stretched) {
	draw_sprite_stretched(_sprite, 4, _x + _spriteWidth, _y + _spriteHeight, _width - _spriteWidth*2, _height - _spriteHeight*2);
} else {
	for (var _xPos = 1; _xPos <= _tileWidth; _xPos++) {
		for (var _yPos = 1; _yPos <= _tileHeight; _yPos++) {
			draw_sprite(_sprite, 4, _x + (_xPos * _spriteWidth), _y + (_yPos * _spriteHeight));	
		}
	}
}

// Middle Right
if (_stretched) {
	draw_sprite_stretched(_sprite, 5, _x + _width - _spriteWidth, _y + _spriteHeight, _spriteWidth, _height - _spriteHeight*2);
} else {
	for (var _yPos = 1; _yPos <= _tileHeight; _yPos++) {
		draw_sprite(_sprite, 5, _x + _width - _spriteWidth, _y + (_yPos * _spriteHeight));	
	}
}

// Bottom Left
draw_sprite(_sprite, 6, _x, _y + _height - _spriteHeight);

// Bottom Center
if (_stretched) {
	draw_sprite_stretched(_sprite, 7, _x + _spriteWidth, _y + _height - _spriteHeight, _width - _spriteWidth*2, _spriteHeight);
} else {
	for (var _xPos = 1; _xPos <= _tileWidth; _xPos++) {
		draw_sprite(_sprite, 7, _x + (_xPos * _spriteWidth), _y + _height - _spriteHeight);
	}
}

// Bottom Right
draw_sprite(_sprite, 8, _x + _width - _spriteWidth, _y + _height - _spriteHeight);

