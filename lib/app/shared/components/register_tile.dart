import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TiemRegisterTile extends StatelessWidget {
  final String text;
  final void Function() onTap;

  const TiemRegisterTile({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: GoogleFonts.dmSans(),
        ),
      ),
    );
  }
}
