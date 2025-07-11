import 'dart:ui';

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onMenuSelected;

  const CustomAppBar({super.key, this.onMenuSelected});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(color: Colors.white.withOpacity(0.7)),
        ),
      ),
      titleSpacing: 16,
      title: Row(
        children: [
          const Icon(Icons.public_rounded, color: Colors.blueAccent, size: 24),
          const SizedBox(width: 12),
          const Text(
            'GeoWise',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert_rounded, color: Colors.black54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'about', child: Text('About')),
            PopupMenuItem(value: 'clear_cache', child: Text('Clear Cache')),
          ],
          onSelected: onMenuSelected,
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
