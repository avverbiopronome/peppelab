#!/bin/zsh
ordine=$(security find-internet-password -gs peppelab.altervista.org |& sed 's/.*"\(.*\)"[^"]*$/\1/' | head -n 1)
ftpsync ./site ftp://peppelab:${ordine}@peppelab.altervista.org/y