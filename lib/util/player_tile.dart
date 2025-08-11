import 'package:flutter/material.dart';
import 'package:trdr/data/database.dart'; // Your Player model

class PlayerTile extends StatelessWidget {
  final Player player;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const PlayerTile({
    super.key,
    required this.player,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMale = player.isMale;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: isMale ? Colors.blue.shade400 : Colors.purple.shade400,
      child: ListTile(
        onTap: onTap,
        leading: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(6),
          child: Icon(
            isMale ? Icons.male : Icons.female,
            color: isMale ? Colors.blue : Colors.pink,
            size: 30,
          ),
        ),
        title: Text(
          player.name,
          style: const TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: onDelete,
          color: Colors.white,
        ),
      ),
    );
  }
}
