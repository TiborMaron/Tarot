import 'package:flutter/material.dart';

class DrawCard extends StatefulWidget {
  const DrawCard({super.key});

  @override
  DrawCardState createState() => DrawCardState();
}

class DrawCardState extends State<DrawCard> {
  bool _showImage = false;

  void _toggleImage() {
    setState(() {
      _showImage = !_showImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(0, 0, 0, 150),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton.icon(
              onPressed: _toggleImage,
              label: const Text('Show Card'),
            ),
          ),
          if (_showImage)
            GestureDetector(
              onTap: _toggleImage,
              child: Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    'assets/cards/the_tower.webp',
                    height: MediaQuery.of(context).size.height * 0.8,
                    fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}