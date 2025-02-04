import 'package:flutter/material.dart';

class DrawCard extends StatefulWidget {
  const DrawCard({super.key});

  @override
  DrawCardState createState() => DrawCardState();
}

class DrawCardState extends State<DrawCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }  

  bool _showImage = false;

  void _toggleImage() {
    setState(() {
      _showImage = !_showImage;
      if (_showImage) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final rotationValue = _controller.value * 3.14159; // PI for 180-degree rotation
                        final isFlipped = rotationValue > 3.14159 / 2;
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(rotationValue),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: isFlipped
                                ? Image.asset(
                                    'assets/cards/the_tower.webp',
                                    fit: BoxFit.contain,
                                  )
                                : Image.asset(
                                    'assets/cards/cover.webp',
                                    fit: BoxFit.contain,
                                  ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(16.0)
                      ),
                      hintText: 'Write your question here!',
                    ),
                    textAlignVertical: TextAlignVertical.top,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _toggleImage,
                  icon: const Icon(Icons.visibility, color: Colors.black),
                  label: const Text(
                    'Show Card',
                    style: TextStyle(color: Colors.black),),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}