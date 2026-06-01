import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF5ECE7),
        borderRadius: BorderRadius.circular(28),
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          context.go('/search');
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Color(0xFF45483C)),
          hintText: "Axtar",
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
