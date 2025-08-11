import 'package:flutter/material.dart';

class GameMode {
  final String emoji;
  final String name;
  final String description;
  final List<Color> colors;
  final bool isPremium;
  bool isSelected = false;

  GameMode({
    required this.emoji,
    required this.name,
    required this.description,
    required this.colors,
    required this.isPremium,
  });
}

final List<GameMode> gameModes = [
  GameMode(
    emoji: '😂',
    name: 'EASY',
    description: 'Fun and light truths & dares for a relaxed start.',
    colors: [Colors.redAccent, Colors.deepOrange],
    isPremium: false,
  ),
  GameMode(
    emoji: '🔥',
    name: 'CHALLENGE',
    description: 'Bold questions and daring tasks for the adventurous.',
    colors: [Colors.deepPurple, Colors.redAccent],
    isPremium: false,
  ),
  GameMode(
    emoji: '😈',
    name: 'DAREDEVIL',
    description: 'Only the bold survive — outrageous couple dares ahead!',
    colors: [Colors.black87, Colors.red],
    isPremium: true,
  ),
  GameMode(
    emoji: '💋',
    name: 'FLIRTY FUN',
    description: 'Cheeky questions and playful dares to turn up the heat.',
    colors: [Colors.pinkAccent, Colors.redAccent],
    isPremium: true,
  ),
  GameMode(
    emoji: '🍷',
    name: 'DATE NIGHT',
    description: 'Romantic yet spicy truths & dares for cozy evenings.',
    colors: [Colors.deepOrange, Colors.purpleAccent],
    isPremium: true,
  ),
  GameMode(
    emoji: '🛏️',
    name: 'AFTER DARK',
    description: 'Steamy and daring — not for the faint of heart!',
    colors: [Colors.deepPurple, Colors.black],
    isPremium: true,
  ),
  GameMode(
    emoji: '🎲',
    name: 'RANDOM SPICE',
    description: 'Wild mix of sweet, flirty, and daring challenges.',
    colors: [Colors.pink, Colors.orangeAccent],
    isPremium: true,
  ),
  GameMode(
    emoji: '💦',
    name: 'WILD MODE',
    description: 'Push your limits with intimate truths & daring dares.',
    colors: [Colors.indigo, Colors.deepPurpleAccent],
    isPremium: true,
  ),
];
