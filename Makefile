PROJECT = redbean.com

SOURCES = $(shell ls src/*.fnl | sed 's/.fnl$$/.lua/' | sed 's/^src/.lua/')

.lua/%.lua: src/%.fnl
	./fennel --compile $< >$@

build: ${SOURCES}
	zip ${PROJECT} .init.lua
	zip -r ${PROJECT} .lua

clean:
	rm -f ${SOURCES}
	zip -qd ${PROJECT} ${SOURCES} || true

debug: clean
	DEBUG=1 ./${PROJECT} -u -D .

repl: clean
	./${PROJECT} -D .

run: clean
	ls ${PROJECT} src/*.fnl | entr -r ./${PROJECT} -u -D .

deps:
	curl https://redbean.dev/redbean-latest.com >${PROJECT} && chmod +x ${PROJECT}
	curl https://raw.githubusercontent.com/pkulchenko/fullmoon/master/fullmoon.lua >.lua/fullmoon.lua
	curl https://raw.githubusercontent.com/slembcke/debugger.lua/master/debugger.lua >.lua/debugger.lua
	cp ~/github/fennel/fennel.lua .lua/
	cp ~/github/fennel/fennel .
	sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"
