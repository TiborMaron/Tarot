import 'package:flutter/material.dart' hide Card;
import 'dart:math' as math;
import '../models/card.dart';
import '../models/card_deck.dart';

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
    _textController.dispose();
    super.dispose();
  }  

  Card? _selectedCard;
  bool _isFlipped = false;
  final TextEditingController _textController = TextEditingController();

  final List<Card> _cardDeck = cardDeck;

  void _toggleCard() {
    setState(() {
      if (!_isFlipped) {
        // TODO: Change it to crytopgraphically safe random generator?
        _selectedCard = _cardDeck[math.Random().nextInt(_cardDeck.length)];
        _controller.forward();
      } else {
        _controller.reverse();
        _textController.clear();
      }
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

            // The Card
            Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final rotationValue = _controller.value * math.pi;
                  final isFlipped = rotationValue > math.pi / 2;
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(rotationValue),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: isFlipped
                          ? Image.asset(
                              _selectedCard?.assetPath ?? '',
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

            // TextField
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _textController,
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

            const SizedBox(height: 10),

            // Button
            ElevatedButton.icon(
              onPressed: _toggleCard,
              icon: Icon(
                _isFlipped ? Icons.cached : Icons.visibility,
                color: Colors.black),
              label: Text(
                _isFlipped ? 'New Question' : 'Show Card',
                style: TextStyle(color: Colors.black),
              ),
            ),
            
            const SizedBox(height: 10),

            ],
            ),
          ),
        ]
      )
    );
  }
}