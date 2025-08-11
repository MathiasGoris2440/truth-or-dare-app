import 'package:flutter/material.dart';
import 'package:trdr/data/database.dart';
import 'package:trdr/util/gender_selector.dart';
import 'package:trdr/util/interaction_icons.dart';
import 'package:trdr/util/name_input_field.dart';
import 'package:trdr/util/buttom_button.dart';

class AddPlayerPage extends StatefulWidget {
  final TextEditingController controller;
  final void Function(bool, Interaction)? saveNewPlayer; // when adding
  final void Function(String name, bool isMale, Interaction interaction)?
      onUpdate; // when editing
  final bool? initialIsMale; // prefill gender
  final Interaction? initialInteraction; // prefill interaction
  final bool isEditing;

  const AddPlayerPage({
    super.key,
    required this.controller,
    this.saveNewPlayer,
    this.onUpdate,
    this.initialIsMale,
    this.initialInteraction,
    this.isEditing = false,
  });

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  late bool isMale;
  late Interaction? interaction;

  @override
  void initState() {
    super.initState();
    isMale = widget.initialIsMale ?? true;
    interaction = widget.initialInteraction;
  }

  void _handleSave() {
    final name = widget.controller.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name')),
      );
      return;
    }

    interaction ??= Interaction.both;

    if (widget.isEditing) {
      widget.onUpdate?.call(name, isMale, interaction!);
    } else {
      widget.saveNewPlayer?.call(isMale, interaction!);
    }
    Navigator.pop(context);
  }

  void onGenderChanged(bool value) {
    setState(() {
      isMale = value;
    });
  }

  void onInteractionChanged(Interaction interaction) {
    setState(() {
      this.interaction = interaction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'PLAYER',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
        child: Padding(
          padding: EdgeInsets.only(
              top: kToolbarHeight + MediaQuery.of(context).padding.top),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    NameInputField(controller: widget.controller),
                    GenderSelector(
                        isMale: isMale, onGenderChanged: onGenderChanged),
                    const Padding(
                      padding: EdgeInsets.only(left: 12, right: 12, top: 12),
                      child: Text('I WANT TO INTERACT WITH:',
                          style: TextStyle(color: Colors.white)),
                    ),
                    InteractionIcons(
                        interaction: interaction,
                        onInteractionChanged: onInteractionChanged),
                  ],
                ),
              ),
              BottomButton(
                onPressed: _handleSave,
                title: 'SAVE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
