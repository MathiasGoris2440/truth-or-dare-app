import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trdr/data/database.dart';
import 'package:trdr/util/add_button.dart';
import 'package:trdr/util/buttom_button.dart';
import 'package:trdr/util/player_tile.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  final _myBox = Hive.box('mybox');
  final PlayersDataBase db = PlayersDataBase();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (_myBox.get("PLAYERS") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
  }

  void saveNewPlayer(bool isMale, Interaction interaction) {
    final playerName = _controller.text.toUpperCase();
    if (playerName.isEmpty) return;

    setState(() {
      final newPlayer =
          Player(name: playerName, isMale: isMale, interaction: interaction);
      db.addPlayer(newPlayer);
      _controller.clear();
    });
  }

  void deletePlayer(int index) {
    setState(() {
      db.removePlayerAt(index);
    });
  }

  void editPlayer(int index) {
    final player = db.players[index];
    _controller.text = player.name; // prefill

    Navigator.pushNamed(context, '/add_player', arguments: {
      'controller': _controller,
      'onUpdate': (String name, bool isMale, Interaction interaction) {
        setState(() {
          db.updatePlayer(
              index,
              Player(
                  name: name.toUpperCase(),
                  isMale: isMale,
                  interaction: interaction));
          _controller.clear();
        });
      },
      'initialIsMale': player.isMale,
      'initialInteraction': player.interaction,
      'isEditing': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    final playerCount = db.players.length;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('PLAYERS', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A2980),
              Color(0xFF26D0CE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: playerCount + 1,
                itemBuilder: (context, index) {
                  if (index < playerCount) {
                    return PlayerTile(
                      player: db.players[index],
                      onDelete: () => deletePlayer(index),
                      onTap: () => editPlayer(index),
                    );
                  } else {
                    return AddPlayerButton(
                      onPressed: () {
                        _controller.clear();
                        Navigator.pushNamed(
                          context,
                          '/add_player',
                          arguments: {
                            'controller': _controller,
                            'saveNewPlayer': saveNewPlayer,
                            'isEditing': false,
                          },
                        );
                      },
                      title: "Add Player",
                    );
                  }
                },
              ),
            ),
            BottomButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/game_modes');
                },
                title: 'CONTINUE'),
          ],
        ),
      ),
    );
  }
}
