#!/bin/bash

# Ścieżki folderów
BASE_DIR="/c/KOMPRESSOR"
IN_DIR="$BASE_DIR/in"
OUT_DIR="$BASE_DIR/out"

# Tworzenie folderów, jeśli nie istnieją
mkdir -p "$IN_DIR" "$OUT_DIR"

echo KOMPRESSOR_v0.1 Alpha

# Wybór rozmiaru
echo "Wjeb plik audio lub wideo:"
read -p "Rozmiar (w MB): " size
size=${size:-10} # Ustaw domyślną wartość 10, jeśli użytkownik nic nie wpisze
MAX_SIZE_BYTES=$((size * 1024 * 1024))

# Wybór pliku do kompresji
echo "Pliki dostępne do kompresji:"
ls "$IN_DIR"
read -p "Podaj nazwę pliku z folderu 'in': " input_file
input_path="$IN_DIR/$input_file"

if [ ! -f "$input_path" ]; then
    echo "Plik nie istnieje!"
    exit 1
fi

# Kompresja pliku
output_file="${input_file%.*}_compressed.${input_file##*.}"
output_path="$OUT_DIR/$output_file"

ffmpeg -i "$input_path" -fs "$MAX_SIZE_BYTES" -y "$output_path"

# Wynik
if [ $? -eq 0 ]; then
    echo "Plik został skompresowany i zapisany do: $output_path"
else
    echo "Wystąpił problem podczas kompresji."
fi
