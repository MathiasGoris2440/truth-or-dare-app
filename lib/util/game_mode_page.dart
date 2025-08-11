import 'package:flutter/material.dart';
import 'package:trdr/data/gamemodes.dart';
import 'package:trdr/util/buttom_button.dart';
import 'package:trdr/util/premium_button.dart';

class GameModePage extends StatefulWidget {
  final int index;
  final GameMode mode;
  final Function(int index) onPageChanged;
  const GameModePage(
      {super.key,
      required this.index,
      required this.mode,
      required this.onPageChanged});

  @override
  State<GameModePage> createState() => _GameModePageState();
}

class _GameModePageState extends State<GameModePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _emojiController;

  late Animation<double> _emojiBounce;

  @override
  void initState() {
    super.initState();

    // Create a controller for emoji bounce animation
    _emojiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    // Move emoji up and down between 0 and -15 pixels
    _emojiBounce = Tween<double>(begin: 0, end: -15).animate(
      CurvedAnimation(parent: _emojiController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emojiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.mode.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated emoji
          AnimatedBuilder(
            animation: _emojiBounce,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _emojiBounce.value),
                child: Text(widget.mode.emoji,
                    style: const TextStyle(fontSize: 72)),
              );
            },
          ),
          const SizedBox(height: 16),

          // Game mode name
          Text(
            widget.mode.name,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),

          // Game mode description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              widget.mode.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ),
          const SizedBox(height: 40),

// Start button
          widget.mode.isPremium
              ? const PremiumButton()
              : BottomButton(
                  onPressed: () {
                    widget.onPageChanged(widget.index);
                  },
                  title: 'START',
                ),
        ],
      ),
    );
  }
}
