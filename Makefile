SERVER = server.com
SOURCES = .init.lua $(shell ls *.fnl | sed 's/.fnl$$/.lua/')

${SERVER}: redbean.com db ${SOURCES}
	cp redbean.com ${SERVER} && zip -r ${SERVER} ${SOURCES} .lua

db: sqlite3.com
	( [ -d db ] || mkdir db ) && ./sqlite3.com db/sqlite3 < schema.sql

%.lua: %.fnl
	fennel --add-macro-path '.lua/?.fnl' -c $< >$@

.PHONY: clean
clean:
	rm -f ${SERVER}

.PHONY: debug
debug:
	DEBUG=1 rlwrap ./${SERVER} -u -D .

.PHONY: repl
repl:
	./${SERVER} -F .init.lua -e "require'fennel'.repl()" -i

.PHONY: reload
reload:
	ls .init.lua .lua/*.fnl | entr -r ./${SERVER} -u -D .

.PHONY: deps
deps:
	curl https://redbean.dev/redbean-latest.com >redbean.com && chmod +x redbean.com
	curl https://redbean.dev/sqlite3.com >sqlite3.com && chmod +x sqlite3.com
	curl https://raw.githubusercontent.com/pkulchenko/fullmoon/master/fullmoon.lua >.lua/fullmoon.lua
	curl https://raw.githubusercontent.com/slembcke/debugger.lua/master/debugger.lua >.lua/debugger.lua
	curl https://raw.githubusercontent.com/starwing/luaiter/master/iter.lua >.lua/batteries/iter.lua
	cp ~/github/fennel/fennel.lua .lua/
	sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"
