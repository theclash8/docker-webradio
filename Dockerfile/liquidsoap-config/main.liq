%include "passwords.liq"
# %include "scheduling.liq"

set("server.telnet", true)
set("server.telnet.bind_addr", "0.0.0.0")
set("server.telnet.port", 1234)
set("log.stdout",true)

test = nrj(playlist(mode='randomize',reload=1,reload_mode="watch", "/data"))
output.icecast(%mp3.vbr,fallible=true, host = "icecast",port=8000,password=source_password,mount="test",name="myStation Main Stream", description="The myStation main stream.", test)

