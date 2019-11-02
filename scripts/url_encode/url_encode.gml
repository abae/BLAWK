/// @description url_encode(str)
/// @param str
//
// Script:      Encode the string <str> in x-www-form-urlencoded format.
// Date:        2014-06-13
// Copyright:   GameGeisha
// Source:      http://gmc.yoyogames.com/index.php?showtopic=596130
//
// Arguments:
// Argument0: the string to encode

var s, hex_digits, special_chars;
s = "";
hex_digits = "0123456789ABCDEF";
special_chars = "$&+,/:;=?@ " + "\"" + "'<>#%{}|\\^~[]`!";

//Main loop
var i, l, c, o, escapes, escape_bytes;
l = string_length(argument0);
for (i=1; i<=l; i+=1) {
    c = string_char_at(argument0, i);
    o = ord(c);
    escapes = 0;
    //Single-byte characters
    if (o <= $7F) {
        if (string_pos(c, special_chars) != 0) or (o < 32) {
            escapes = 1;
            escape_bytes[0] = o;
        }
    }
    //2-byte characters
    else if (o <= $7FF) {
        escapes = 2;
        escape_bytes[0] = (o>>6)+192;
        escape_bytes[1] = (o&63)+128;
    }
    //3-byte characters
    else if (o <= $FFFF) { 
        escapes = 3;
        escape_bytes[0] = (o>>12)+224;
        escape_bytes[1] = ((o>>6)&63)+128;
        escape_bytes[2] = (o&63)+128;
    }
    //Too long
    else {
        show_error("Invalid character.", true);
    }
    //Dump in escape characters, if any
    if (escapes == 0) {
        s += c;
    }
    else {
        var j;
        for (j=0; j<escapes; j+=1) {
            s += "%" + string_char_at(hex_digits, (escape_bytes[j]>>4)+1) + string_char_at(hex_digits, (escape_bytes[j]&15)+1);
        }
    }
}

//Done
return s;

