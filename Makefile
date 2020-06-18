shell:
	nix-shell

build:
	dune build play.bc

clean:
	rm -rf _build

run:
	_build/default/play.bc

gen:
	atdgen -t raft.atd
	atdgen -j raft.atd

fmt:
	dune build @fmt --auto-promote
