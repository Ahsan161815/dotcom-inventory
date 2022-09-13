import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/inventory_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inventoryProvider = Provider.of<Inventory>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Clear Data',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    inventoryProvider.cleardata();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.blue,
                        content: Text(
                          'Data deleted succefully',
                        )));
                  },
                  label: Text('clear'),
                  icon: Icon(
                    Icons.clear,
                    size: 20,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
