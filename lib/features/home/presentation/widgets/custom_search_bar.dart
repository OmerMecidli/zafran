import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zafran/core/theme/app_theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainer,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppTheme.onSurfaceVariant.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          context.go('/search');
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Color(0xFF45483C)),
          hintText: 'Axtar',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
