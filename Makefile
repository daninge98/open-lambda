GOPATH:=$(PWD)
WORKER:=worker
WORKER_SRC:=worker/*.go

SERVER_BIN:=worker/worker
CLIENT_BIN:=worker/prof/client/client

.PHONY: $(WORKER)
worker : $(WORKER_SRC)
	cd hack && ./build.sh
	mkdir -p bin
	cp $(SERVER_BIN) bin/worker
	cp $(CLIENT_BIN) bin/client

clean :
	rm -rf bin
	rm -rf hack/.gopath
	rm $(SERVER_BIN)
	rm $(CLIENT_BIN)

.PHONY: node
node : worker
	mkdir -p node/bin
	cp bin/worker node/bin/worker
	docker build -t lambda-node node