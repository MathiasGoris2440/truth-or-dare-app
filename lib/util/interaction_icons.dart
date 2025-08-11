import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trdr/data/database.dart';

class InteractionIcons extends StatefulWidget {
  final Interaction? interaction;
  final void Function(Interaction interaction)? onInteractionChanged;

  const InteractionIcons(
      {super.key, this.interaction, this.onInteractionChanged});

  @override
  State<InteractionIcons> createState() => _InteractionIconsState();
}

class _InteractionIconsState extends State<InteractionIcons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              widget.onInteractionChanged?.call(Interaction.male);
            },
            icon: Icon(
              Icons.male,
              size: 36,
              color: widget.interaction == Interaction.male
                  ? Colors.black // full bright when selected
                  : Colors.black.withOpacity(0.6), // dimmed when not selected
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                widget.interaction == Interaction.male
                    ? Colors.white // bright background
                    : Colors.white.withOpacity(0.6), // dimmed background
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.onInteractionChanged?.call(Interaction.female);
              });
            },
            icon: Icon(
              Icons.female,
              size: 36,
              color: widget.interaction == Interaction.female
                  ? Colors.black // full bright when selected
                  : Colors.black.withOpacity(0.6), // dimmed when not selected
            ),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                widget.interaction == Interaction.female
                    ? Colors.white // bright background
                    : Colors.white.withOpacity(0.6), // dimmed background
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                widget.onInteractionChanged?.call(Interaction.both);
              });
            },
            icon: SvgPicture.asset('assets/icons/both_genders.svg',
                width: 36,
                height: 36,
                colorFilter: ColorFilter.mode(
                  widget.interaction == Interaction.both
                      ? Colors.black // full bright when selected
                      : Colors.black.withOpacity(0.6),
                  BlendMode.srcIn, // dimmed when not selected
                )),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                widget.interaction == Interaction.both
                    ? Colors.white // bright background
                    : Colors.white.withOpacity(0.6), // dimmed background
              ),
            ),
          ),
        ],
      ),
    );
  }
}
