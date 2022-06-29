#!/bin/bash
###
# Chimera requires a license acceptance to allow downloads, and the installer needs user interaction.
# This script automates some of this to help package into the Docker image.
#
# More info: https://www.cgl.ucsf.edu/chimera/download.html
###

# Do all of this in the tmp folder.
tmp_dir=/tmp/$$_chimera
echo "Creating temp directory ${tmp_dir}"
mkdir ${tmp_dir}
cd ${tmp_dir}

CHIMERA_LINK="https://www.cgl.ucsf.edu$(curl -X POST -d "choice=Accept&file=linux_x86_64_osmesa%2Fchimera-1.16-linux_x86_64_osmesa.bin" -X POST https://www.cgl.ucsf.edu/chimera/cgi-bin/secure/chimera-get.py | grep "href=\"/chimera" | sed 's/.*"\(.*\)".*/\1/')"

echo $CHIMERA_LINK

curl $CHIMERA_LINK --output chimera_installer.bin

unzip chimera_installer.bin
./chimera.bin -q -d /opt/chimera
ln -s /opt/chimera/bin/chimera /usr/local/bin

cd /
rm -rf ${tmp_dir}
 