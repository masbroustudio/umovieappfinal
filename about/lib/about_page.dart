import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(120),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                foregroundImage: Image.asset(
                  'assets/yudhae.png',
                ).image,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32.0),
              child: const Text(
                'uMovie merupakan sebuah aplikasi katalog film yang dikembangkan oleh Yudha Elfransyah sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
