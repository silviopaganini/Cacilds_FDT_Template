var swfVersionStr = "10.1.0";
var xiSwfUrlStr = "swf/playerProductInstall.swf";

var flashvars = {
		xmlPath   : "data/content.xml",
		cssPath   : "data/styles.css",
		fontsPath : "swf/font.swf"
};

var params = {
    quality             : "best",
    bgcolor             : "${htmlColor}",
    allowscriptaccess   : "sameDomain",
    allowfullscreen     : "true"
};

var attributes = {
    id      : "Main",
    name    : "Main",
    align   : "middle"
};
swfobject.embedSWF(
    "swf/${projectNameBuild}.swf", "flashContent", 
    "${htmlWidth}", "${htmlHeight}", 
    swfVersionStr, xiSwfUrlStr, 
    flashvars, params, attributes);

swfobject.createCSS("#flashContent", "display:block;text-align:left;");