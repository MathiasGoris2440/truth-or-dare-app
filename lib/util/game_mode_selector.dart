import 'package:flutter/material.dart';
import 'package:trdr/data/gamemodes.dart';

class GameModeSelector extends StatefulWidget {
  const GameModeSelector({super.key});

  @override
  State<GameModeSelector> createState() => _GameModeSelectorState();
}

class _GameModeSelectorState extends State<GameModeSelector> {
  final List<GameMode> _gameModes = List<GameMode>.from(gameModes);

  void _onGameModeTap(int index) {
    final selected = _gameModes[index];

    if (selected.isSelected) return;

    if (selected.isPremium) {
      Navigator.pushNamed(context, '/premium');
    } else {
      setState(() {
        for (var mode in _gameModes) {
          mode.isSelected = false;
        }
        selected.isSelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _gameModes.length,
        itemBuilder: (context, index) {
          final mode = _gameModes[index];
          return GestureDetector(
            onTap: () => _onGameModeTap(index),
            child: Container(
              margin: const EdgeInsets.only(left: 6, bottom: 12),
              width: 130,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: mode.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  if (!mode.isSelected)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mode.emoji,
                          style: TextStyle(
                            fontSize: 24,
                            color: mode.isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          mode.name,
                          style: TextStyle(
                            color: mode.isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  if (mode.isPremium)
                    const Positioned(
                      top: 8,
                      right: 15,
                      child: Icon(
                        Icons.lock_rounded,
                        size: 16,
                        color: Color.fromARGB(157, 255, 255, 255),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
