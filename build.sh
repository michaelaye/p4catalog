#!/bin/bash

mkdir -p $CONDA_PREFIX/share/intake/planet4
cp $RECIPE_DIR/planet4.yaml $CONDA_PREFIX/share/intake/
cp $RECIPE_DIR/planet4_files.yaml $CONDA_PREFIX/share/intake/planet4