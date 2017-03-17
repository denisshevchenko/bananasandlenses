#!/bin/bash
set -eux

stack build
stack exec -- bananasandlenses rebuild
