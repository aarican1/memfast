import 'package:flutter/material.dart';

class AnimatedDownArrow extends StatefulWidget {
  final Color color;
  final double size;

  const AnimatedDownArrow({
    super.key,
    this.color = Colors.white, // Varsayılan renk
    this.size = 40, // Varsayılan boyut
  });

  @override
  State<AnimatedDownArrow> createState() => _AnimatedDownArrowState();
}

class _AnimatedDownArrowState extends State<AnimatedDownArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // 1. Animasyon Kontrolcüsü (Sürekli tekrar edecek)
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // 1 saniyede inip kalksın
      vsync: this,
    )..repeat(reverse: true); // Aşağı git ve geri gel

    // 2. Animasyon Eğrisi (Daha yumuşak hareket için EaseInOut)
    _animation = Tween<double>(
      begin: 0.0,
      end: 10.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder sayesinde her değer değişiminde CustomPaint yeniden çizilir
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.size, widget.size), // Çizim alanı boyutu
          painter: _ArrowPainter(
            color: widget.color,
            offsetY: _animation.value, // Hareket değeri buraya gidiyor
          ),
        );
      },
    );
  }
}

// --- Çizim Sınıfı ---
class _ArrowPainter extends CustomPainter {
  final Color color;
  final double offsetY; // Animasyondan gelen hareket değeri

  _ArrowPainter({required this.color, required this.offsetY});

  @override
  void paint(Canvas canvas, Size size) {
    // Kalem ayarları
    final paint =
        Paint()
          ..color = color
          ..strokeWidth =
              4.0 // Çizgi kalınlığı
          ..strokeCap =
              StrokeCap
                  .round // Uçlar yuvarlak olsun
          ..style = PaintingStyle.stroke;

    final path = Path();

    // Okun dikey çizgisinin uzunluğu ve konumu
    final double centerX = size.width / 2;
    // offsetY değerini ekleyerek aşağı yukarı hareketi sağlıyoruz
    final double startY = (size.height * 0.2) + offsetY;
    final double endY = (size.height * 0.8) + offsetY;
    final double arrowHeadSize = size.width * 0.25; // Ok ucunun büyüklüğü

    // 1. Dikey gövde çizimi (Yukarıdan aşağıya)
    path.moveTo(centerX, startY);
    path.lineTo(centerX, endY);

    // 2. Sol kanat (Uçtan sola yukarı)
    path.moveTo(centerX, endY);
    path.lineTo(centerX - arrowHeadSize, endY - arrowHeadSize);

    // 3. Sağ kanat (Uçtan sağa yukarı)
    path.moveTo(centerX, endY);
    path.lineTo(centerX + arrowHeadSize, endY - arrowHeadSize);

    // Çizimi ekrana bas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) {
    // Eğer Y konumu değiştiyse tekrar çiz
    return oldDelegate.offsetY != offsetY;
  }
}
