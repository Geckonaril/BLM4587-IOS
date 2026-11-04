import 'package:flutter/material.dart';

import 'day_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  final VoidCallback? onLogout;

  const CalendarScreen({super.key, this.onLogout});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  static const mor = Color(0xFF6655D9);
  static const koyuMor = Color(0xFF4333A4);
  static const turkuaz = Color(0xFF39B7A4);

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

  static const haftaGunleri = ['Pzt', 'Sal', 'Çar', 'Per', 'Cum', 'Cmt', 'Paz'];

  late DateTime goruntulenenAy;
  late DateTime secilenGun;

  @override
  void initState() {
    super.initState();

    final bugun = DateTime.now();

    goruntulenenAy = DateTime(bugun.year, bugun.month);
    secilenGun = bugun;
  }

  bool ayniGunMu(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void ayDegistir(int fark) {
    setState(() {
      goruntulenenAy = DateTime(
        goruntulenenAy.year,
        goruntulenenAy.month + fark,
      );
    });
  }

  void buguneGit() {
    final bugun = DateTime.now();

    setState(() {
      goruntulenenAy = DateTime(bugun.year, bugun.month);
      secilenGun = bugun;
    });
  }

  void gunDetayiniAc(DateTime tarih) {
    setState(() {
      secilenGun = tarih;
    });

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => DayDetailScreen(selectedDate: tarih)),
    );
  }

  Widget ayButonu(IconData simge, VoidCallback tiklama) {
    return Material(
      color: Colors.white.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: tiklama,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(simge, color: Colors.white),
        ),
      ),
    );
  }

  Widget takvimKarti() {
    final ilkGun = DateTime(goruntulenenAy.year, goruntulenenAy.month, 1);

    final gunSayisi = DateTime(
      goruntulenenAy.year,
      goruntulenenAy.month + 1,
      0,
    ).day;

    final bosGunSayisi = ilkGun.weekday - 1;

    // Takvim satırlarının her biri 7 hücre içermeli.
    final hucreSayisi = ((bosGunSayisi + gunSayisi + 6) ~/ 7) * 7;

    final bugun = DateTime.now();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: mor.withValues(alpha: 0.07),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: haftaGunleri.map((gun) {
              return Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      gun,
                      style: const TextStyle(
                        color: Color(0xFF8B8BA5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 4),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
            ),
            itemCount: hucreSayisi,
            itemBuilder: (context, index) {
              final gun = index - bosGunSayisi + 1;

              if (gun < 1 || gun > gunSayisi) {
                return const SizedBox.shrink();
              }

              final tarih = DateTime(
                goruntulenenAy.year,
                goruntulenenAy.month,
                gun,
              );

              final seciliMi = ayniGunMu(tarih, secilenGun);
              final bugunMu = ayniGunMu(tarih, bugun);

              return Semantics(
                button: true,
                label:
                    '$gun '
                    '${aylar[tarih.month - 1]} '
                    '${tarih.year}',
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => gunDetayiniAc(tarih),
                  child: Center(
                    child: Container(
                      width: 39,
                      height: 39,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: seciliMi ? mor : Colors.transparent,
                        shape: BoxShape.circle,
                        border: bugunMu && !seciliMi
                            ? Border.all(color: turkuaz, width: 2)
                            : null,
                      ),
                      child: Text(
                        '$gun',
                        style: TextStyle(
                          color: seciliMi
                              ? Colors.white
                              : const Color(0xFF303047),
                          fontWeight: seciliMi || bugunMu
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 14),

          const Divider(color: Color(0xFFF0EFF5)),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 11,
                height: 11,
                decoration: const BoxDecoration(
                  color: mor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 7),
              const Text('Seçilen gün', style: TextStyle(fontSize: 12)),
              const SizedBox(width: 20),
              Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: turkuaz, width: 2),
                ),
              ),
              const SizedBox(width: 7),
              const Text('Bugün', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tarihYazisi =
        '${secilenGun.day} '
        '${aylar[secilenGun.month - 1]} '
        '${secilenGun.year}';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 34),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF8070ED), koyuMor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            'Takvim+',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: buguneGit,
                          icon: const Icon(
                            Icons.today_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: const Text(
                            'Bugün',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Çıkış yap',
                          onPressed: widget.onLogout,
                          icon: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Gününü planla, anılarını biriktir.',
                      style: TextStyle(color: Color(0xFFEAE5FF), fontSize: 14),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ayButonu(
                          Icons.chevron_left_rounded,
                          () => ayDegistir(-1),
                        ),
                        Expanded(
                          child: Text(
                            '${aylar[goruntulenenAy.month - 1]} '
                            '${goruntulenenAy.year}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ayButonu(
                          Icons.chevron_right_rounded,
                          () => ayDegistir(1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Transform.translate(
                offset: const Offset(0, -14),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: takvimKarti(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEAFF),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.event_available_rounded,
                          color: mor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Seçilen tarih',
                              style: TextStyle(
                                color: Color(0xFF746B9B),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tarihYazisi,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF38305E),
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Etkinlikler yakında burada!',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF746B9B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
