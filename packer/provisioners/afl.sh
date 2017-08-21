#!/bin/bash --login
# Build from source in order to support Qemu Instrumentation:
# Found in https://github.com/mirrorer/afl/README.md => "4) Instrumenting binary-only apps"
# sudo apt-get purge -y afl afl-clang afl-cov afl-doc
# sudo apt autoremove -y
sudo apt install libtool libtool-bin libglib2.0-dev
sudo /bin/bash --login -c 'cd /opt && git clone https://github.com/mirrorer/afl && cd /opt/afl && make && cd /opt/afl/qemu_mode && ./build_qemu_support.sh'
