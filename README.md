
# Takvim Mobil Uygulaması

BLM4587 - Mobil Uygulama Geliştirme Dönem Projesi

## Proje Hakkında

Xiaomi Takvim uygulamasından esinlenen,
Flutter ile geliştirilen Android takvim uygulaması.

Kullanıcıların etkinlik oluşturmasını, düzenlemesini,
silmesini ve takvim üzerinden görüntülemesini
sağlamak hedeflenmektedir.

## Kullanılan Teknolojiler

- Flutter / Dart
- ASP.NET Core Web API (.NET 10)
- PostgreSQL (planlanan)
- Entity Framework Core (planlanan)

## Klasör Yapısı

- mobile/ : Flutter mobil uygulaması
- api/ : ASP.NET Core Web API

## Mobil Uygulamayı Çalıştırma

1. mobile klasörüne geçin.
2. flutter pub get komutunu çalıştırın.
3. flutter devices ile Android cihazı doğrulayın.
4. flutter run ile uygulamayı başlatın.

## API'yi Çalıştırma

Depo ana dizininde:

dotnet restore api/Takvim.Api.csproj

dotnet run --project api/Takvim.Api.csproj --urls http://localhost:5080 -p:RazorLangVersion=Latest

API kontrol adresi:

GET http://localhost:5080/api/health

## 1. Hafta Çalışmaları

- Flutter ve Android geliştirme ortamı kuruldu.
- Gerçek Android telefonda uygulama çalıştırıldı.
- Hot Reload test edildi.
- Flutter başlangıç ekranı oluşturuldu.
- ASP.NET Core Web API projesi oluşturuldu.
- API health endpoint'i yazıldı ve test edildi.

## Sonraki Adımlar

- PostgreSQL veritabanı tasarımı
- Entity Framework Core entegrasyonu
- Takvim arayüzünün geliştirilmesi
- Kullanıcı ve etkinlik yönetimi
