#!/bin/sh

mkdir -p /app/storage /app/bootstrap/cache

setfacl -R -m u:www-data:rwX -m u:"$(whoami)":rwX /app/storage /app/bootstrap/cache
setfacl -dR -m u:www-data:rwX -m u:"$(whoami)":rwX /app/storage /app/bootstrap/cache