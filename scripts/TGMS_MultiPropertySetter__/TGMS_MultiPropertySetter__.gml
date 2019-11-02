/// TGMS_MultiPropertySetter__(amount,data[],target)

// var _amount = argument0;
// var _target = argument2;

// I can speed this up by creating multi setter scripts for various counts...
// This would eliminate the need for switch statement

var _data = argument1;

switch(_data[0]) // Property Count
{
    case 2:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        return script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
    
    case 3:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        return script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
    
    case 4:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
        return script_execute(_data[19] , lerp(_data[20], _data[21], argument0), _data[22], argument2, _data[23]);
    
    case 5:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
        script_execute(_data[19] , lerp(_data[20], _data[21], argument0), _data[22], argument2, _data[23]);
        return script_execute(_data[25] , lerp(_data[26], _data[27], argument0), _data[28], argument2, _data[29]);
    
    case 6:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
        script_execute(_data[19] , lerp(_data[20], _data[21], argument0), _data[22], argument2, _data[23]);
        script_execute(_data[25] , lerp(_data[26], _data[27], argument0), _data[28], argument2, _data[29]);
        return script_execute(_data[31] , lerp(_data[32], _data[33], argument0), _data[34], argument2, _data[35]);
    
    case 7:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
        script_execute(_data[19] , lerp(_data[20], _data[21], argument0), _data[22], argument2, _data[23]);
        script_execute(_data[25] , lerp(_data[26], _data[27], argument0), _data[28], argument2, _data[29]);
        script_execute(_data[31] , lerp(_data[32], _data[33], argument0), _data[34], argument2, _data[35]);
        return script_execute(_data[37] , lerp(_data[38], _data[39], argument0), _data[40], argument2, _data[41]);
    
    case 8:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
        script_execute(_data[19] , lerp(_data[20], _data[21], argument0), _data[22], argument2, _data[23]);
        script_execute(_data[25] , lerp(_data[26], _data[27], argument0), _data[28], argument2, _data[29]);
        script_execute(_data[31] , lerp(_data[32], _data[33], argument0), _data[34], argument2, _data[35]);
        script_execute(_data[37] , lerp(_data[38], _data[39], argument0), _data[40], argument2, _data[41]);
        return script_execute(_data[43] , lerp(_data[44], _data[45], argument0), _data[46], argument2, _data[47]);
    
    case 9:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
        script_execute(_data[19] , lerp(_data[20], _data[21], argument0), _data[22], argument2, _data[23]);
        script_execute(_data[25] , lerp(_data[26], _data[27], argument0), _data[28], argument2, _data[29]);
        script_execute(_data[31] , lerp(_data[32], _data[33], argument0), _data[34], argument2, _data[35]);
        script_execute(_data[37] , lerp(_data[38], _data[39], argument0), _data[40], argument2, _data[41]);
        script_execute(_data[43] , lerp(_data[44], _data[45], argument0), _data[46], argument2, _data[47]);
        return script_execute(_data[49] , lerp(_data[50], _data[51], argument0), _data[52], argument2, _data[53]);
    
    case 10:
        script_execute(_data[1] , lerp(_data[2], _data[3], argument0), _data[4], argument2, _data[5]);
        script_execute(_data[7] , lerp(_data[8], _data[9], argument0), _data[10], argument2, _data[11]);
        script_execute(_data[13] , lerp(_data[14], _data[15], argument0), _data[16], argument2, _data[17]);
        script_execute(_data[19] , lerp(_data[20], _data[21], argument0), _data[22], argument2, _data[23]);
        script_execute(_data[25] , lerp(_data[26], _data[27], argument0), _data[28], argument2, _data[29]);
        script_execute(_data[31] , lerp(_data[32], _data[33], argument0), _data[34], argument2, _data[35]);
        script_execute(_data[37] , lerp(_data[38], _data[39], argument0), _data[40], argument2, _data[41]);
        script_execute(_data[43] , lerp(_data[44], _data[45], argument0), _data[46], argument2, _data[47]);
        script_execute(_data[49] , lerp(_data[50], _data[51], argument0), _data[52], argument2, _data[53]);
        return script_execute(_data[55] , lerp(_data[56], _data[57], argument0), _data[58], argument2, _data[59]);
}
 