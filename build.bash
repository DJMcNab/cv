set -e

echo "Building PDF"
typst compile ./src/main.typ --font-path fonts --format pdf --root . out/cv.pdf

echo "Building PNG"
typst compile ./src/main.typ --font-path fonts --format png --root . --ppi 200 out/cv_unopt.png

oxipng -o max -Z out/cv_unopt.png --out out/cv.png
