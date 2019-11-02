///draw_text_highscore(x,y,text1,text2,text3,highscores,name,color)
//
// Script:      Draws a highscore with the player’s name coloured in green
// Date:        2018-07-21
// Copyright:   Appsurd
//
// Arguments:
// Argument0: x
// Argument1: y
// Argument2: The text to display above the index
// Argument3: The text to display above the name
// Argument4: The text to display above the score
// Argument5: The highscore text
// Argument6: The name to colour
// Argument7: The color to give to the name of argument6

var xx = argument0;
var yy = argument1;
var str = argument5;
var name = argument6;
var colour = argument7;

// Initialise the drawing by splitting up the text
var def_color = draw_get_colour();
var count = string_count("|",str);
var str2 = string_split("|",str,true);
var str3,str3a,str3b,str3c;
str3[0] = string(argument2)+".-"+string(argument3)+"-"+string(argument4);
for(var i=0; i<count; i+=1)
{
    str3[i+1] = str2[i];
}

// Setting some parameters, if you wish, you can change them to values you think are convenient.
var height = 0;
var max_la = 20; // minimum width of the first column (the nr.)
var max_lb = 100; // minimum width of the name column
var max_lc = 20; // minimum width of the score column

// Splitting up the text into a part with the number (3a), the name (3b) and the score (3c)
// Currently, the return is encoded by Nr.-Name-Score
for(var i=0; i<count+1; i+=1)
{
    var str4 = string_split("-",str3[i],false);
    txt3a[i] = str4[0];
    txt3b[i] = str4[1];
    txt3c[i] = str4[2];
  
    // Decode the name so we can use it (but do not decode the header containing "name" since it's not decoded!)
    if i != 0
    {
        txt3b[i] = base64_decode(txt3b[i]);
    }
  
    // Assure that if a player has a # in his name, then escape
    txt3b[i] = string_replace_all(txt3b[i],"#","\#");
  
    // Adjust the width such that the text doesn't overlap
    max_la = max(string_width(txt3a[i]),max_la);
    max_lb = max(string_width(txt3b[i]),max_lb);
    max_lc = max(string_width(txt3c[i]),max_lc);
}
txt3a[0] = "";

// The actual drawing of the highscores
for(var i=0; i<count+1; i+=1)
{
    if name == txt3b[i]
    {
        draw_set_color(colour);
    }
    else
    {
        draw_set_color(def_color);
    }
  
    // Draw the numbers
    draw_set_halign(fa_right);
    draw_text(xx+max_la+5,yy+height,txt3a[i]);
  
    // Assure that if a player has a # in his name, then escape (I know I'm doing this twice
    // but that's needed for the string_width in the previous block to work properly
    txt3b[i] = string_replace_all(txt3b[i],"#","\#");
  
    // Draw the name + score
    draw_set_halign(fa_left);
    draw_text(xx+max_la+10,yy+height,txt3b[i]);
    draw_text(xx+max_la+10+max_lb+10,yy+height,txt3c[i]);
  
    height += string_height(str3[i]);
}