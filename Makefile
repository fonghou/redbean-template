SERVER = server.com

${SERVER}:
	cp redbean.com ${SERVER}
	cp src/* .lua/
	zip -r ${SERVER} .init.lua .lua *.lua

release: ${SERVER}
	cp src/* .lua/ && zip -r ${SERVER} .lua

clean:
	rm -f ${SERVER}

debug:
	DEBUG=1 rlwrap ./${SERVER} -u -D .

repl:
	./${SERVER} -F .init.lua -e "require'fennel'.repl()" -i

reload: ${SERVER}
	ls ${SERVER} src/*.fnl | entr -r ./${SERVER} -u -D .

db:
	./sqlite3.com db/sqlite3 < schema.sql

deps:
	curl https://redbean.dev/redbean-latest.com >redbean.com && chmod +x redbean.com
	curl https://redbean.dev/sqlite3.com >sqlite3.com && chmod +x sqlite3.com
	curl https://raw.githubusercontent.com/pkulchenko/fullmoon/master/fullmoon.lua >.lua/fullmoon.lua
	curl https://raw.githubusercontent.com/slembcke/debugger.lua/master/debugger.lua >.lua/debugger.lua
	cp ~/github/fennel/fennel.lua .lua/
	sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"
