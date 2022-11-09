import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../data/data.dart';
import '../models/order.dart';

class orders_screen extends StatefulWidget {
  const orders_screen({Key? key}) : super(key: key);

  @override
  State<orders_screen> createState() => _orders_screenState();
}

class _orders_screenState extends State<orders_screen> {

  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];
  final List<Order> waiting_order=[];

  @override
  Widget build(BuildContext context) {

    String? selectedValue;
    final List<String> items=[];
    for(var j=0;j<restaurants.length;j++){
      items.add(restaurants[j].name!);
    }


    // for(var i=0;i<currentUser.orders!.length;i++){
    //   print("currentUser restaurant: ${currentUser.orders![i].restaurant?.name}\nselectedValue: $selectedValue");
    //   if(currentUser.orders![i].restaurant!.name=='Restaurant 0'){
    //     waiting_order.add(currentUser.orders![i]);
    //     print("waiting_order list add:${waiting_order}");
    //   }
    // }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, '/');
          },
          icon: Icon(
            Icons.arrow_back,
          ),
          iconSize: 30,
        ),
        title: Text(
          'Orders',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Flexible(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              'Select Item',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: items
                          .map((item) =>
                          DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value as String;

                          for(var i=0;i<currentUser.orders!.length;i++){
                            print("currentUser restaurant: ${currentUser.orders![i].restaurant?.name}\nselectedValue: $selectedValue");
                            if(currentUser.orders![i].restaurant!.name==selectedValue){
                              waiting_order.add(currentUser.orders![i]);
                              // print("waiting_order list add:${waiting_order}");
                            }
                          }

                          print("order.length: ${waiting_order.length}");
                        });
                      },
                      iconSize: 14,
                      buttonHeight: 50,
                      buttonWidth: 300,
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                      buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.black26,
                        ),
                      ),
                      // buttonElevation: 2,
                      itemHeight: 40,
                      itemPadding: const EdgeInsets.only(left: 14, right: 14),
                      dropdownMaxHeight: 200,
                      dropdownWidth: 200,
                      dropdownPadding: null,
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      dropdownElevation: 8,
                      scrollbarRadius: const Radius.circular(40),
                      scrollbarThickness: 6,
                      scrollbarAlwaysShow: true,
                      offset: const Offset(-20, 0),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            ButtonTheme(
              minWidth: 250,
              height: 40.0,
              child: RaisedButton(
                onPressed: () {
                  setState(() {

                  });
                },
                child: Text("test"),
              ),
            ),
            Column(
              children: [
                ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: waiting_order.length,
                  // itemCount: currentUser.orders!.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("ListView index:$index");
                    return Container(
                      height: 50,
                      color: Colors.amber[200],
                      child: Center(child: Text('name: ${waiting_order[index].food!.name}\ndate: ${waiting_order[index].date}')),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
              ],
            ),
            // ListView.separated(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   padding: const EdgeInsets.all(8),
            //   itemCount: waiting_order.length,
            //   // itemCount: currentUser.orders!.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     print("ListView index:$index");
            //     return Container(
            //       height: 50,
            //       color: Colors.amber[200],
            //       child: Center(child: Text('name: ${waiting_order[index].food!.name}\ndate: ${waiting_order[index].date}')),
            //     );
            //   },
            //   separatorBuilder: (BuildContext context, int index) => const Divider(),
            // ),
          ],
        ),
      ),
    );




  }
}
