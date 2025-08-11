import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:trdr/data/database.dart';
import 'package:trdr/util/game_mode_selector.dart';

class PlayerPickerPage extends StatefulWidget {
  const PlayerPickerPage({super.key});

  @override
  State<PlayerPickerPage> createState() => _PlayerPickerPageState();
}

class _PlayerPickerPageState extends State<PlayerPickerPage> {
  final StreamController<int> _streamController = StreamController<int>();
  final PlayersDataBase _db = PlayersDataBase();

  int _chosenIndex = 0;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _spinWheel() {
    setState(() {
      _chosenIndex = Fortune.randomInt(0, _db.getPlayers().length);
      _streamController.add(_chosenIndex);
    });
  }

  void _onWheelEnd() {
    final selectedPlayer = _db.getPlayers()[_chosenIndex].name;
    Navigator.pushNamed(
      context,
      '/truth_or_dare',
      arguments: {'playerName': selectedPlayer},
    );
  }

  Color _getPlayerColor(int index) {
    final colors = [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
      Colors.orangeAccent,
      Colors.purpleAccent,
      Colors.teal,
      Colors.pinkAccent,
      Colors.amberAccent,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final players = _db.getPlayers();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.only(
          top: kToolbarHeight + MediaQuery.of(context).padding.top,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Who's Turn?",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Spin the wheel to select the next player.",
              style: TextStyle(fontSize: 16, color: Colors.grey[400]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            GestureDetector(
              onTap: _spinWheel,
              child: SizedBox(
                height: 350,
                child: FortuneWheel(
                  animateFirst: false,
                  selected: _streamController.stream,
                  onAnimationEnd: _onWheelEnd,
                  styleStrategy: const UniformStyleStrategy(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    color: Colors.deepPurpleAccent,
                    borderColor: Colors.white,
                    borderWidth: 2,
                  ),
                  indicators: const [
                    FortuneIndicator(
                      alignment: Alignment.topCenter,
                      child: TriangleIndicator(color: Colors.white),
                    ),
                  ],
                  items: players.asMap().entries.map((entry) {
                    final index = entry.key;
                    final player = entry.value;
                    return FortuneItem(
                      child: Text(player.name),
                      style: FortuneItemStyle(
                        color: _getPlayerColor(index),
                        borderColor: Colors.white,
                        borderWidth: 2,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 64),
            MaterialButton(
              onPressed: _spinWheel,
              color: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: const Text(
                "🎯 Spin the Wheel!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            const GameModeSelector(),
          ],
        ),
      ),
    );
  }
}
