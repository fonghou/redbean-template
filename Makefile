SERVER = server.com
LUASRC = $(shell fd -e lua -e fnl -E '*macro*.fnl' | sed 's/.fnl$$/.lua/')

${SERVER}: redbean.com ${LUASRC}
	cp redbean.com ${SERVER} && zip -r ${SERVER} .args .init.lua .lua tmpl/ ${LUASRC}

%.lua: %.fnl
	fennel -c $< >$@

.PHONY: js
js:
	npx squint compile asset/*.cljs

.PHONY: clean
clean:
	rm -f ${SERVER}

.PHONY: debug
debug:
	DEBUG=1 rlwrap ./${SERVER} -p 8888 -uv -D .

.PHONY: repl
repl:
	./${SERVER} -i -D . -F .init.lua -e "require'fennel'.repl()"

.PHONY: reload
reload:
	find .init.lua .lua tmpl | entr -r ./${SERVER} -p 8888 -D .

.PHONY: deps
deps:
	curl https://raw.githubusercontent.com/pkulchenko/fullmoon/master/fullmoon.lua >.lua/fullmoon.lua
	curl https://raw.githubusercontent.com/slembcke/debugger.lua/master/debugger.lua >.lua/debugger.lua
	curl https://raw.githubusercontent.com/kikito/inspect.lua/master/inspect.lua >.lua/inspect.lua
	curl https://raw.githubusercontent.com/neovim/neovim/master/runtime/lua/vim/iter.lua >.lua/iter.lua
	curl https://raw.githubusercontent.com/andreyorst/itable/main/src/itable.fnl >.lua/itable.fnl
	cp ~/github/fennel/fennel.lua .lua/
	sudo sh -c "echo ':APE:M::MZqFpD::/usr/bin/ape:' >/proc/sys/fs/binfmt_misc/register"
