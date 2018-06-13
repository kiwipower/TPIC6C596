#require "Rocky.class.nut:2.0.0"

app <- Rocky();

app.put("/updateBigLed/([^/]*)", function(context) {
    // Grab the value from the regex
    local value = context.matches[1];
    device.send("updateBigLed", value.tointeger());
    context.send({"success": value});
});