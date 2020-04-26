%include "passwords.liq"
# %include "scheduling.liq"

set("server.telnet", true)
set("server.telnet.bind_addr", "0.0.0.0")
set("server.telnet.port", 1234)
set("log.stdout",true)

set("harbor.bind_addr","0.0.0.0")
playlist = nrj(playlist(mode='randomize',reload=1,reload_mode="watch", "/data/"))
live = input.harbor("live",port=8080,password="hackme")
source = fallback(id="Mod <-> mAirList",track_sensitive=false,[live,playlist])

output.icecast(%mp3.vbr,fallible=true, host = "icecast",port=8000,password=source_password,mount="test",name="myStation Main Stream", description="The myStation main stream.", source)
