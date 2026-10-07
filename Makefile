src ?= testdir
dest ?= quarantine

.PHONY: antivirusd setup restore

antivirusd: setup
	./antivirusd.sh $(src) $(dest) 3

restore: setup
	./restore.sh $(src) $(dest)

setup:
	mkdir -p $(src)
	mkdir -p $(dest)
