import 'package:dotcomi/controller/inventory_controller.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _qtyController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String addItem(String name, int qty) {
    if (name != null && qty != null) {
      Provider.of<Inventory>(context, listen: false).addItem(
        name,
        qty,
      );
      Navigator.pop(context);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name')),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                addItem(_nameController.text, 0);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.blue,
                    content: Text(
                      'Item added succefully',
                    )));
              },
              child: Text(
                'Add',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              )),
        ],
      ),
    );
  }
}
