set -e

echo "Building PDF"
typst compile ./src/main.typ --font-path fonts --format pdf --root . out/cv.pdf

echo "Building PNG"
typst compile ./src/main.typ --font-path fonts --format png --root . --ppi 200 out/cv.png

oxipng -o max -Z out/cv.png
