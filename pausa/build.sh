#!/usr/bin/env sh
# Genera index.html (versión instalable) a partir de app.html.
cd "$(dirname "$0")"
{
  printf '%s\n' '<!doctype html>' '<html lang="es">' '<head>' \
    '<meta charset="utf-8">' \
    '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">' \
    '<meta name="theme-color" content="#2E6A64">' \
    '<meta name="apple-mobile-web-app-capable" content="yes">' \
    '<meta name="apple-mobile-web-app-title" content="Pausa">' \
    '<link rel="manifest" href="manifest.webmanifest">' \
    '<link rel="icon" href="icon.svg" type="image/svg+xml">' \
    '<link rel="apple-touch-icon" href="icon.svg">' \
    '<script src="config.js"></script>' \
    '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}[hidden]{display:none!important}img{max-width:100%}</style>' \
    '</head>' '<body>'
  cat app.html
  printf '%s\n' '</body>' '</html>'
} > index.html
