#!/bin/sh -l

cd "$1"

poetry install
poetry run blurry build