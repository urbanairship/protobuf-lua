.PHONY: all rockspec build clean

VERSION=1.1.0
BUILDDIR = build
NAME = protobuf-$(VERSION)-0
OUTPUTDIR = $(BUILDDIR)/$(NAME)

all: build

rockspec:
	mkdir -p $(OUTPUTDIR)
	sed "s/%VERSION%/$(VERSION)/g" protobuf.rockspec > $(OUTPUTDIR)/$(NAME).rockspec

build: rockspec
	mkdir -p $(OUTPUTDIR)/lua/protobuf
	mkdir -p $(OUTPUTDIR)/src
	cp README.md LICENSE $(OUTPUTDIR)/
	cp -R protobuf/*.lua $(OUTPUTDIR)/lua/protobuf/
	cp -R protobuf/*.c $(OUTPUTDIR)/src/
	cp -R protoc-plugin $(OUTPUTDIR)/
	(cd $(BUILDDIR); tar czvpf $(NAME).tar.gz $(NAME)/)

install: build
	cd $(OUTPUTDIR); luarocks make $(NAME).rockspec

clean:
	rm -rf $(BUILDDIR)
	find . -name "*.pyc" -exec rm -rf {} \;
