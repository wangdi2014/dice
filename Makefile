SHELL := /bin/bash


all: 	src/dice

src/dice: libgab/utils.o bamtools/build/src/api/libbamtools.a
	make -C src

libgab/utils.h:
	rm -rf libgab/
	git clone --recursive https://github.com/grenaud/libgab.git

libgab/utils.o: bamtools/build/src/api/libbamtools.a  libgab/utils.h
	make -C libgab

bamtools/src/api/BamAlignment.h:
	rm -rf bamtools/
	git clone --recursive https://github.com/pezmaster31/bamtools.git && cd bamtools/ && git reset --hard d24d850de17134fe4e7984b26493c5c0a1844b35


bamtools/build/src/api/libbamtools.a: bamtools/src/api/BamAlignment.h
	cd bamtools/ && mkdir -p build/  && cd build/ && cmake .. && make && cd ../..

clean:
	make -C libgab clean
	make -C src clean


.PHONY: all
