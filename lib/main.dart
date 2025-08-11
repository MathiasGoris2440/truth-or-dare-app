import 'package:flutter/material.dart';
import 'package:trdr/data/database.dart';
import 'package:trdr/pages/add_player_page.dart';
import 'package:trdr/pages/game_modes_page.dart';
import 'package:trdr/pages/player_picker.dart';
import 'package:trdr/pages/players_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:trdr/pages/premium_page.dart';
import 'package:trdr/pages/truth_or_dare_pick_screen.dart';

void main() async {
  //init the hive
  await Hive.initFlutter();

  //open a box
  await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      home: const PlayersPage(),
      routes: {
        '/players': (context) => const PlayersPage(),
        '/add_player': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return AddPlayerPage(
            controller: args['controller'] as TextEditingController,
            saveNewPlayer:
                args['saveNewPlayer'] as void Function(bool, Interaction)?,
            onUpdate:
                args['onUpdate'] as void Function(String, bool, Interaction)?,
            initialIsMale: args['initialIsMale'] as bool?,
            initialInteraction: args['initialInteraction'] as Interaction?,
            isEditing: (args['isEditing'] as bool?) ?? false,
          );
        },
        '/game_modes': (context) => const GameModesPage(),
        '/premium': (context) => const PremiumPage(),
        '/player_picker': (context) => const PlayerPickerPage(),
        '/truth_or_dare': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return TruthOrDarePickScreen(
            playerName: args['playerName'] as String,
          );
        },
      },
    );
  }
}
