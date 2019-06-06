#!/bin/bash

mkdir -p $CONDA_PREFIX/share/intake/p4data
cp $RECIPE_DIR/p4data.yaml $CONDA_PREFIX/share/intake/
cp $RECIPE_DIR/p4data_sub.yaml $CONDA_PREFIX/share/intake/p4data