import 'package:hive_flutter/hive_flutter.dart';

enum Interaction { male, female, both }

class Player {
  final String name;
  final bool isMale;
  final Interaction interaction;

  const Player(
      {required this.name,
      required this.isMale,
      this.interaction = Interaction.both});

  Map<String, dynamic> toMap() => {
        'name': name,
        'isMale': isMale,
        'interaction': interaction.name,
      };

  factory Player.fromMap(Map<String, dynamic> map) {
    // Try to parse `interaction` from either string or int, with safe fallback.
    Interaction parseInteraction(dynamic raw) {
      if (raw is String) {
        // match by enum name; fallback to both
        final idx = Interaction.values.indexWhere((e) => e.name == raw);
        return idx == -1 ? Interaction.both : Interaction.values[idx];
      } else if (raw is int) {
        // treat as enum index if in range
        return (raw >= 0 && raw < Interaction.values.length)
            ? Interaction.values[raw]
            : Interaction.both;
      }
      return Interaction.both;
    }

    return Player(
      name: map['name'] as String? ?? 'UNKNOWN',
      isMale: map['isMale'] as bool? ?? true, // default to true if missing
      interaction: parseInteraction(map['interaction']),
    );
  }

  Player copyWith({
    String? name,
    bool? isMale,
    Interaction? interaction,
  }) =>
      Player(
        name: name ?? this.name,
        isMale: isMale ?? this.isMale,
        interaction: interaction ?? this.interaction,
      );
}

class PlayersDataBase {
  PlayersDataBase() : _box = Hive.box('mybox');

  final Box _box;
  List<Player> players = const [];

  /// Creates some starter data
  void createInitialData() {
    players = const [
      Player(name: 'PLAYER 1', isMale: true, interaction: Interaction.male),
      Player(name: 'PLAYER 2', isMale: false, interaction: Interaction.female),
    ];
    updateDataBase();
  }

  /// Loads data from Hive safely
  void loadData() {
    final rawList = _box.get('PLAYERS', defaultValue: const []) as List;
    players = rawList
        .map((e) => Player.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList(growable: false);
  }

  List<Player> getPlayers() {
    loadData();
    return players;
  }

  /// Saves data to Hive
  void updateDataBase() {
    _box.put('PLAYERS', players.map((p) => p.toMap()).toList(growable: false));
  }

  // add a player
  void addPlayer(Player p) {
    players = [...players, p];
    updateDataBase();
  }

  // remove a player
  void removePlayerAt(int index) {
    if (index < 0 || index >= players.length) return;
    players = [...players]..removeAt(index);
    updateDataBase();
  }

  // update an existing player
  void updatePlayer(int index, Player p) {
    if (index < 0 || index >= players.length) return;
    final updated = [...players]..[index] = p;
    players = updated;
    updateDataBase();
  }
}
