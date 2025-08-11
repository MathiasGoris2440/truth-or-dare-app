import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:trdr/data/gamemodes.dart';
import 'package:trdr/util/game_mode_page.dart';

class GameModesPage extends StatefulWidget {
  const GameModesPage({super.key});

  @override
  State<GameModesPage> createState() => _GameModesPageState();
}

class _GameModesPageState extends State<GameModesPage> {
  // Page controller for swiping between game modes
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      gameModes[index].isSelected = true;
      for (int i = 0; i < gameModes.length; i++) {
        if (i != index) {
          gameModes[i].isSelected = false;
        }
      }
    });
    Navigator.pushNamed(context, '/player_picker');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Background PageView with full-screen pages
          PageView.builder(
            controller: _pageController,
            itemCount: gameModes.length,
            itemBuilder: (context, index) {
              return GameModePage(
                  index: index,
                  mode: gameModes[index],
                  onPageChanged: onPageChanged);
            },
          ),

          // Page indicator at bottom
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: gameModes.length,
                effect: const WormEffect(
                  dotWidth: 10,
                  dotHeight: 10,
                  activeDotColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
