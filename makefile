# use "make -f makefile.unix RELEASE=TRUE" to create release executable

CC	= g++

GFLAGS	= -Wall -Wstrict-prototypes `sdl-config --cflags`

CFLAGS	= $(GFLAGS) -mcpu=arm1176jzf-s -march=armv6zk -O2 -funroll-loops -ffast-math -fomit-frame-pointer -fno-strength-reduce -finline-functions -s

LIBS = -L/usr/lib/arm-linux-gnueabihf -lz -lts -L/opt/vc/lib -lGLESv2 -lEGL

cpc4rpi: cpc4rpi.cpp crtc.o fdc.o psg.o tape.o z80.o cap32.h z80.h
	$(CC) $(CFLAGS) $(IPATHS) -o cpc4rpi cpc4rpi.cpp crtc.o fdc.o psg.o tape.o z80.o /root/Raspbian/Libs/libSDL.a /root/Raspbian/Libs/libnofun.a $(LIBS)

crtc.o: crtc.c draw_8bpp.c draw_16bpp.c draw_24bpp.c draw_32bpp.c cap32.h crtc.h z80.h
	$(CC) $(CFLAGS) -c crtc.c

fdc.o: fdc.c cap32.h z80.h
	$(CC) $(CFLAGS) -c fdc.c

psg.o: psg.c cap32.h z80.h
	$(CC) $(CFLAGS) -c psg.c

tape.o: tape.c cap32.h tape.h z80.h
	$(CC) $(CFLAGS) -c tape.c

z80.o: z80.c z80.h cap32.h
	$(CC) $(CFLAGS) -c z80.c

clean:
	rm *.o cpc4rpi
