#!/bin/bash

# Список вебсайтів, які потрібно перевірити
websites=(
    "https://google.com"
    "https://facebook.com"
    "https://twitter.com"
    "https://github.com"
    "https://non-existent-website-12345.org" # Приклад недоступного сайту
)

# Файл для запису результатів
logfile="website_status.log"

# Очищуємо файл логів перед кожним запуском
> "$logfile"

# Вивід повідомлення про старт роботи
echo "Starting website availability check..."

# Цикл для перевірки кожного сайту зі списку
for site in "${websites[@]}"; do
    status_code=$(curl -s -o /dev/null -L --connect-timeout 10 -w "%{http_code}" "$site")

    # Перевіряємо, чи є статус-код 200 (OK)
    if [ "$status_code" -eq 200 ]; then
        echo "$site is UP" >> "$logfile"
    else
        echo "$site is DOWN" >> "$logfile"
    fi
done

# Вивід повідомлення про завершення роботи
echo "Check complete. Results have been saved to the log file: $logfile"