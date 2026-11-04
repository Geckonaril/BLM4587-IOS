
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

### Hafta 2 — Veritabanı ve Takvim Arayüzü

- PostgreSQL üzerinde `takvim_flutter` veritabanı oluşturuldu.
- Entity Framework Core ve Npgsql entegrasyonu yapıldı.
- Users, Calendars, Events, Categories ve Reminders tabloları modellendi.
- Tablolar arasındaki bire-çok ilişkiler tanımlandı.
- `InitialCreate` migration oluşturuldu ve veritabanına uygulandı.
- Flutter aylık takvim ekranı geliştirildi.
- Aylar arasında geçiş ve bugüne dönme özellikleri eklendi.
- Gün Detayı ekranı oluşturuldu.
- `Navigator.push` ve `Navigator.pop` ile ekranlar arası gezinme sağlandı.
- Gerçek Android cihaz üzerinde ekran testleri gerçekleştirildi.

### Hafta 3 — Kullanıcı Kimlik Doğrulama ve Yetkilendirme

- ASP.NET Core Web API üzerinde kullanıcı kayıt ve giriş endpoint'leri geliştirildi.
- Kullanıcı parolalarının güvenli şekilde hashlenerek PostgreSQL veritabanında saklanması sağlandı.
- JWT tabanlı kimlik doğrulama sistemi oluşturuldu.
- `User` ve `Admin` rolleri tanımlandı; rol bazlı API erişim kontrolleri uygulandı.
- API üzerinden `401 Unauthorized`, `403 Forbidden` ve `200 OK` yanıtlarıyla yetkilendirme testleri gerçekleştirildi.
- Flutter tarafında Takvim+ tasarımına uygun giriş ve kayıt ekranları geliştirildi.
- Form doğrulamaları eklenerek hatalı e-posta ve parola girişleri kontrol edildi.
- Flutter ile Web API arasında HTTP üzerinden kayıt ve giriş entegrasyonu sağlandı.
- JWT bilgilerinin `flutter_secure_storage` kullanılarak güvenli biçimde saklanması ve oturumun korunması sağlandı.
- Kullanıcı çıkış yapma özelliği eklendi.
- Gerçek Android cihaz üzerinde kayıt, giriş ve rol yetkilendirme işlemleri test edildi.

**Sonraki Hafta:** Etkinlik yönetimi için RESTful Web API CRUD endpoint'lerinin geliştirilmesi, Swagger/OpenAPI üzerinden test edilmesi ve Flutter uygulamasında etkinlik ekleme, listeleme, güncelleme ve silme işlemlerinin uygulanması.