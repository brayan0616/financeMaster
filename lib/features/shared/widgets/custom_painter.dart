import 'package:flutter/material.dart';

class _HeaderDiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    lapiz.color = const Color.fromARGB(255, 97, 90, 171);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 4;

    final path = Path();

    //*dibujar con el path y el lapiz
    path.lineTo(0,0);
    path.lineTo(size.width,size.height);
    path.lineTo(0,size.height);
    // path.moveTo(0, size.height * 0.35);
    // path.quadraticBezierTo(size.width * 0.5, size.height * 0.4, size.width, size.height * 0.35);

    canvas.drawPath(path, lapiz);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }

}

class _HeaderTriangularPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    lapiz.color = Color(0xFFB0F2C2).withOpacity(0.8);
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 4;

    final path = Path();

    //*dibujar con el path y el lapiz
    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width * 0.5, size.height * 0.45);
    path.lineTo(size.width, size.height * 0.35);
    path.lineTo(size.width,0);
    path.lineTo(0,0);
    // path.quadraticBezierTo(size.width * 0.5, size.height * 0.4, size.width, size.height * 0.35);

    canvas.drawPath(path, lapiz);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }

}

class _HeaderCurvoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = Paint();

    lapiz.color = Color(0xFFB0F2C2).withOpacity(0.9);
    lapiz.style = PaintingStyle.fill;
    // lapiz.style = PaintingStyle.stroke;
    lapiz.strokeWidth = 2;

    final path = Path();

    //*dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.30);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.5 , size.width, size.height * 0.30);
    path.lineTo(size.width,0);
    path.lineTo(0,0);
    // path.quadraticBezierTo(size.width * 0.5, size.height * 0.4, size.width, size.height * 0.35);

    canvas.drawPath(path, lapiz);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    
    return true;
  }

}