#!/bin/bash
###
# Tfbio is a manual setup.
# This script automates some of this to help package into the Docker image.
#
# More info: https://gitlab.com/cheminfIBB/tfbio
###

# Do all of this in the tmp folder.
tmp_dir=/tmp/$$_installer
echo "Creating temp directory ${tmp_dir}"
mkdir ${tmp_dir}
cd ${tmp_dir}

# Download the source, which comes as a zip.
DOWNLOAD_LINK="https://gitlab.com/cheminfIBB/tfbio/-/archive/master/tfbio-master.zip"
echo "Downloading: ${DOWNLOAD_LINK}"
curl ${DOWNLOAD_LINK} --output source.zip

# Unzip the source and run installer.
unzip source.zip
cd tfbio-master
python setup.py install

cd /
rm -rf ${tmp_dir}
 