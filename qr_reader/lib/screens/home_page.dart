import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/screens/addresses_page.dart';
import 'package:qr_reader/screens/instagram_post_page.dart';
import 'package:qr_reader/screens/maps_page.dart';
import 'package:qr_reader/screens/tweets_page.dart';
import 'package:qr_reader/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historial',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Provider.of<ScanListProvider>(context, listen: false)
                      .deleteAll();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Todo el historial eliminado')),
                  );
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                )),
          )
        ],
      ),
      body: const _HomePageBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomNavigatorbar(),
      floatingActionButton: ScanButton(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScanByType('geo');
        return MapsPage();
      case 1:
        scanListProvider.loadScanByType('http');
        return AddressesPage();
      case 2:
        scanListProvider.loadScanByType('tweets');
        return TweetsPage();
      case 3:
        scanListProvider.loadScanByType('instagram');
        return InstagramPostsPage();
      default:
        return MapsPage();
    }
  }
}
