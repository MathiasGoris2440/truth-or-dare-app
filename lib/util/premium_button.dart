import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({super.key});

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(10));
    const gradient = LinearGradient(
      colors: [Colors.purple, Colors.pink],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: borderRadius,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/premium');
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: BorderSide.none, // border handled by DecoratedBox
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: const RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            icon: Icon(
              Icons.star_rounded,
              size: 36,
              color: Colors.amber.shade200,
            ),
            label: Text(
              'PREMIUM',
              style: GoogleFonts.montserrat(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: 2,
                color: Colors.white,
                shadows: const [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
