.POSIX:

XCFLAGS = ${CPPFLAGS} ${CFLAGS} -nostdlib -std=c99 -fPIC -Wall -Wno-pedantic
XLDFLAGS = ${LDFLAGS} -shared -Wl

all: libgtk-x11-3.0.so.0 libgdk-x11-3.0.so.0

.c.o:
	${CC} ${XCFLAGS} -c -o $@ $<

libgtk-x11-3.0.so.0:
	${CC} ${XCFLAGS} libgtk-x11-3.0.c -o libgtk-x11-3.0.so.0 ${XLDFLAGS},-soname,libgtk-x11-3.0.so.0

libgdk-x11-3.0.so.0:
	${CC} ${XCFLAGS} libgdk-x11-3.0.c -o libgdk-x11-3.0.so.0 ${XLDFLAGS},-soname,libgdk-x11-3.0.so.0

install: libgtk-x11-3.0.so.0 libgdk-x11-3.0.so.0
	mkdir -p ${DESTDIR}/usr/lib64
	cp -f *.so.0 ${DESTDIR}/usr/lib64
	ln -rsf ${DESTDIR}/usr/lib64/libgtk-x11-3.0.so.0 ${DESTDIR}/usr/lib64/libgtk-x11-3.0.so
	ln -rsf ${DESTDIR}/usr/lib64/libgdk-x11-3.0.so.0 ${DESTDIR}/usr/lib64/libgdk-x11-3.0.so
	mkdir -p ${DESTDIR}/usr/lib64/pkgconfig
	cp -f pc/* ${DESTDIR}/usr/lib64/pkgconfig
	mkdir -p ${DESTDIR}/usr/include/gtk-3.0/gtk
	cp -rf headers/* ${DESTDIR}/usr/include/gtk-3.0
uninstall:
	rm -f ${DESTDIR}/usr/lib64/libgtk-x11-3.0.so.0 ${DESTDIR}/usr/lib64/libgdk-x11-3.0.so.0

clean:
	rm -f *.so.0

.PHONY: all clean install uninstall
