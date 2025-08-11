import 'package:flutter/material.dart';
import 'dart:math';

class TruthOrDarePickScreen extends StatefulWidget {
  final String playerName;
  const TruthOrDarePickScreen({super.key, required this.playerName});

  @override
  State<TruthOrDarePickScreen> createState() => _TruthOrDarePickScreenState();
}

class _TruthOrDarePickScreenState extends State<TruthOrDarePickScreen> {
  String? selectedCard; // "truth" or "dare"
  String? selectedContent;

  final List<String> truths = [
    "What's your biggest fear?",
    "Who was your first crush?",
    "What's a secret you've never told anyone?"
  ];

  final List<String> dares = [
    "Do 10 jumping jacks.",
    "Sing a song loudly.",
    "Act like a monkey for 10 seconds."
  ];

  String getRandom(List<String> list) => list[Random().nextInt(list.length)];

  @override
  Widget build(BuildContext context) {
    const Duration animDur = Duration(milliseconds: 420);

    return Scaffold(
      backgroundColor: Colors.deepPurple[900],
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
          )),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "🎉 ${widget.playerName}'s Turn!",
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            if (selectedCard == null)
              const Text(
                "Choose Truth or Dare",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                ),
              ),

            // cards area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: LayoutBuilder(builder: (context, constraints) {
                  // available height for the card area
                  final double areaH = constraints.maxHeight;
                  // visual constants - tweak if you like
                  const double orHeightDefault = 116;
                  const double verticalMargin =
                      40; // top+bottom margin inside area

                  // compute collapsed height (when both shown) so both + OR fit
                  double collapsedHeight =
                      ((areaH - orHeightDefault - verticalMargin) / 2)
                          .clamp(88.0, 160.0);

                  // when expanded, leave some margin so it doesn't truly fullscreen
                  double expandedHeight = (areaH - 20).clamp(200.0, areaH);

                  // final heights depending on state
                  final double truthH = selectedCard == null
                      ? collapsedHeight
                      : (selectedCard == "truth" ? expandedHeight : 0.0);
                  final double dareH = selectedCard == null
                      ? collapsedHeight
                      : (selectedCard == "dare" ? expandedHeight : 0.0);
                  final double orH =
                      selectedCard == null ? orHeightDefault : 0.0;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TRUTH card
                      AnimatedContainer(
                        duration: animDur,
                        curve: Curves.easeInOut,
                        height: truthH,
                        child: Opacity(
                          opacity:
                              (selectedCard == null || selectedCard == "truth")
                                  ? 1.0
                                  : 0.0,
                          child: _buildCard(
                            title: "TRUTH",
                            color: Colors.blue[400]!,
                            isSelected: selectedCard == "truth",
                            content: selectedContent,
                            onTap: () {
                              if (selectedCard == null) {
                                setState(() {
                                  onCardSelected("truth");
                                });
                              }
                            },
                          ),
                        ),
                      ),

                      // OR divider (animated size + fade)
                      AnimatedContainer(
                        duration: animDur,
                        curve: Curves.easeInOut,
                        height: orH,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 220),
                          opacity: selectedCard == null ? 1.0 : 0.0,
                          child: Center(
                            child: Text(
                              "—  OR  —",
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),

                      // DARE card
                      AnimatedContainer(
                        duration: animDur,
                        curve: Curves.easeInOut,
                        height: dareH,
                        child: Opacity(
                          opacity:
                              (selectedCard == null || selectedCard == "dare")
                                  ? 1.0
                                  : 0.0,
                          child: _buildCard(
                            title: "DARE",
                            color: Colors.red[400]!,
                            isSelected: selectedCard == "dare",
                            content: selectedContent,
                            onTap: () {
                              if (selectedCard == null) {
                                onCardSelected("dare");
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  bool showButtons = false;
  void onCardSelected(String type) {
    setState(() {
      selectedCard = type;
      selectedContent = getRandom(type == "truth" ? truths : dares);
      showButtons = false; // Hide initially
    });

    Future.delayed(const Duration(milliseconds: 120), () {
      // After animation duration, show buttons
      if (mounted) {
        setState(() => showButtons = true);
      }
    });
  }

  Widget _buildCard({
    required String title,
    required Color color,
    required bool isSelected,
    required String? content,
    required VoidCallback onTap,
  }) {
    const BorderRadius br = BorderRadius.all(Radius.circular(18));
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      child: InkWell(
        borderRadius: br,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: br,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: br,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: isSelected
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Title at the top
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),

                        // Content in the middle, scrollable if needed
                        if (showButtons)
                          Text(
                            content ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),

                        // Buttons fixed at bottom
                        if (showButtons)
                          Row(
                            children: [
                              MaterialButton(
                                shape: const StadiumBorder(),
                                color: Colors.white,
                                child: const Row(
                                  children: [
                                    Icon(Icons.refresh,
                                        color: Colors.blue, size: 24),
                                    SizedBox(width: 8),
                                    Text(
                                      "Redo",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  setState(() {
                                    // re-roll based on which card is open
                                    if (title == "TRUTH") {
                                      selectedContent = getRandom(truths);
                                    } else if (title == "DARE") {
                                      selectedContent = getRandom(dares);
                                    }
                                  });
                                },
                              ),
                              const Spacer(),
                              MaterialButton(
                                shape: const StadiumBorder(),
                                color: Colors.white,
                                child: const Row(
                                  children: [
                                    Icon(Icons.check_circle,
                                        color: Colors.green, size: 24),
                                    SizedBox(width: 8),
                                    Text(
                                      "Done",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                      ],
                    ),
                  )
                : Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
