# Sayısal Loto Analiz

## Gereksinimler

 - Php 5.5 veya üstü
 - Mysql 5 veya üstü

## Kurulum

 - data/milli_piyango.sql dosyasını import edin.
 - includes/connect.php içinde db ayarlarınızı girin.
 - php public/update.php dosyasını çalıştırarak crawling başlatın
 
## Örnek SQL

 - Hangi Rakam kaç kere çekildi.
 
   SELECT count(number), number FROM loto_numbers GROUP BY number ORDER BY count(number)
 
## TODO List

 - Veri Raporlama
 - Görsel İstatistik