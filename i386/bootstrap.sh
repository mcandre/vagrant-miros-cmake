#!/bin/sh
sudo env PKG_PATH=https://www.mirbsd.org/MirOS/v10/Pkgs/i386 /usr/mpkg/sbin/pkg_add patchutils-0.2.31-1 &&
    tar xzvf /tmp/cmake-3.9.0.tar.gz &&
    rm /tmp/cmake-3.9.0.tar.gz &&
    sh -c "cd cmake-3.9.0 && \
        patch -p0 </tmp/core.c.patch &&
        patch -p0 </tmp/fs.c.patch &&
        patch -p0 </tmp/getaddrinfo.c.patch &&
        patch -p0 </tmp/getnameinfo.c.patch &&
        patch -p0 </tmp/stream.c.patch &&
        patch -p0 </tmp/udp.c.patch &&
        patch -p0 </tmp/CMakeLists.txt.patch &&
        cp /tmp/mirbsd.c Utilities/cmlibuv/src/unix &&
        find . -name '*.orig' -print -exec rm -rf \"{}\" \; &&
        env CC=mgcc CXX=g++ -D_POSIX_SOURCE=1 ./configure --prefix=/usr && \
        make && \
        sudo make install" &&
    rm -rf cmake-3.9.0 &&
    sudo /usr/mpkg/sbin/pkg_delete patchutils-0.2.31-1
