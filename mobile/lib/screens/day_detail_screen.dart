import 'package:flutter/material.dart';

class DayDetailScreen extends StatelessWidget {
  final DateTime selectedDate;

  const DayDetailScreen({super.key, required this.selectedDate});

  static const mor = Color(0xFF6655D9);

  static const aylar = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];

  static const gunler = [
    'Pazartesi',
    'Salı',
    'Çarşamba',
    'Perşembe',
    'Cuma',
    'Cumartesi',
    'Pazar',
  ];

  @override
  Widget build(BuildContext context) {
    final tarihYazisi =
        '${selectedDate.day} '
        '${aylar[selectedDate.month - 1]} '
        '${selectedDate.year}';

    final haftaGunu = gunler[selectedDate.weekday - 1];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Takvim+',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8070ED), Color(0xFF4333A4)],
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.wb_sunny_rounded,
                      color: Color(0xFFFFD479),
                      size: 32,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Seçtiğin gün',
                      style: TextStyle(color: Color(0xFFEAE5FF), fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      tarihYazisi,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      haftaGunu,
                      style: const TextStyle(
                        color: Color(0xFFEAE5FF),
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              const Text(
                'Günün Etkinlikleri',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF29283C),
                ),
              ),

              const SizedBox(height: 14),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0EDFF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.event_note_rounded,
                        color: mor,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Henüz etkinlik yok',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Etkinliklerini çok yakında '
                      'buradan takip edebileceksin.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF88869B), height: 1.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: mor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(17),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text(
                  'Takvime Dön',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
