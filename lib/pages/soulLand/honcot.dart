import 'package:flutter/material.dart';

class HonCotPage extends StatefulWidget {
  const HonCotPage({super.key});

  @override
  State<HonCotPage> createState() => _HonCotPageState();
}

class _HonCotPageState extends State<HonCotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
      ),
      body: const Center(
        child: Text('Hồn cốt'),
      ),
    );
  }
}
