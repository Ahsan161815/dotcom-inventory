import 'package:dotcomi/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controller/inventory_controller.dart';
import 'additem.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.inventory),
        title: Text(
          'DotCom Inv',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => SettingScreen())));
            },
          ),
          Consumer<Inventory>(
            builder: (context, value, child) {
              return Center(
                  child: Text(
                'Qty: ${value.qty}',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ));
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: ItemsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.blueAccent.withOpacity(0.05),
                child: AddItem(),
              );
            },
          );
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(SnackBar(content: Text('Hello')));
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (_) => AddItemScreen()));
        },
        child: Text(
          '+',
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inventoryProvider = Provider.of<Inventory>(context);
    return Consumer<Inventory>(
      builder: (context, value, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Dismissible(
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  inventoryProvider.deleteItem(index, value.items[index].name);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.blue,
                      content: Text(
                        'item deleted succefully',
                      )));
                },
                key: UniqueKey(),
                child: ListTile(
                    tileColor: Colors.blueAccent.withOpacity(0.05),
                    title: Text(
                      value.items[index].name,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          letterSpacing: 1),
                    ),
                    // leading: Text(in.toString()),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 50,
                            height: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onSubmitted: ((num) {
                                inventoryProvider.editItem(
                                    index: index,
                                    key: value.items[index].name,
                                    num: int.parse(num));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        backgroundColor: Colors.blue,
                                        content: Text(
                                          'Qty edited succefully',
                                        )));
                              }),
                              decoration: InputDecoration(
                                focusColor: Colors.blue,
                                hintText: inventoryProvider.items[index].qty
                                    .toString(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                enabledBorder: InputBorder.none,
                                focusedBorder: OutlineInputBorder(),
                              ),
                            )),
                      ],
                    )),
              ),
            );
          },
          itemCount: value.items.length,
        );
      },
    );
  }
}
