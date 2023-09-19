.PHONY: build 

build: deps
	gcc -g -Os -static -nostdlib -nostdinc -fno-pie -no-pie -mno-red-zone \
	-o out.cosmobuild src/main.c \
	-fno-omit-frame-pointer -pg -mnop-mcount -mno-tls-direct-seg-refs -gdwarf-4 \
	-fuse-ld=bfd -Wl,-T,cosmo/ape.lds -Wl,--gc-sections \
	-Wl,-z,common-page-size=0x1000 -Wl,-z,max-page-size=0x1000 \
	-include cosmo/cosmopolitan.h cosmo/crt.o cosmo/ape-no-modify-self.o cosmo/cosmopolitan.a
	objcopy -S -O binary out.cosmobuild main.com


deps:	
	wget https://justine.lol/cosmopolitan/cosmopolitan-amalgamation-2.2.zip && unzip -o cosmopolitan-amalgamation-2.2.zip -d cosmo
