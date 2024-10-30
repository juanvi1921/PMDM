import 'package:flutter/material.dart';
import 'package:qr_reader/widgets/scan_tiles.dart';

class InstagramPostsPage extends StatelessWidget {
  const InstagramPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'instagram');
  }
}
