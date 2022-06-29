#!/bin/bash
##
# PyTorch for Geometric with specific  pip installing.
# This script automates some of this to help package into the Docker image.
#
# More info: https://github.com/pyg-team/pytorch_geometric
##

# Get details of what we currently have for PyTorch.
version=$(pip show torch | grep Version: | awk '{print $2}')

pip install torch-scatter -f https://data.pyg.org/whl/torch-${version}.html
pip install torch-sparse -f https://data.pyg.org/whl/torch-${version}.html
pip install torch-geometric
