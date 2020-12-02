#!/bin/bash
#
# change TwinOaks 
#    Extensibility( blah) 
# to OMG's / RTI's 
#   Extensibility blah
# The passed file is modified in-place
sed --in-place 's:Extensibility[(]\(.*\)[)]:Extensibility \1:' $1
