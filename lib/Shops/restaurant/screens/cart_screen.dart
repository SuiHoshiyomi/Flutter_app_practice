import 'dart:convert';

import 'package:etherwallet/Shops/restaurant/data/data.dart';
import 'package:etherwallet/components/contract_application/get_application_name.dart';
import 'package:etherwallet/components/requests/second_oauth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import '../../../model/network_type.dart';
import '../../../service/configuration_service.dart';
import '../../../service/contract_locator.dart';
import '../models/cart.dart';
// import '../models/order.dart';
import '../../../components/requests/order_post.dart';


// [1, Restaurant0, 0xc2458e81a94e8d477fe1ca03eb3b083a49c55529, 1、2、3、4, http://210.70.80.14/images/restaurant0.jpg, restaurant0 introduction, restaurant0 type]
// restaurant[0] = id
// restaurant[1] = restaurant name
// restaurant[2] = blockchain address
// restaurant[3] = menu id
// restaurant[4] = image url

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.restaurant}) : super(key: key);

  final List restaurant;

  @override
  _CartScreenState createState() => _CartScreenState();
}

const String rpcUrl = 'http://210.70.80.14:22000';
const bool finished_payment=false;

class _CartScreenState extends State<CartScreen> {
  Container _buildCartItem(Product product, CartModel cart) {
    // final myController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(20),
      height: 170,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(product.imgUrl!),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Text(
                        //   product.restaurant,
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        SizedBox(height: 15),
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 0.8,
                              color: Colors.black54,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      if (product.qty >= 1){
                                        setState(() {
                                          product.qty--;
                                        });
                                      }
                                      if(product.qty == 0){
                                        cart.removeProduct(product);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
                                      width: 20,
                                      child: Text(
                                        ' - ',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                              ),

                              Flexible(
                                  child: Text(
                                    product.qty.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ),

                              // if(product.qty<10)
                              //   SizedBox(
                              //     width: 10,
                              //   ),
                              // if(product.qty>=10)
                              //   SizedBox(
                              //     width: 5,
                              //   ),

                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    if (product.qty >= 1){
                                      setState(() {
                                        product.qty++;
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    width: 25,
                                    child: Text(
                                      ' +',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
            // margin: EdgeInsets.all(5),
            child: Text(
              '\$${(product.qty * product.price).round()}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  late final String restaurant_id;

  @override
  void initState() {
    restaurant_id= widget.restaurant[0];
    print(restaurant_id);
    print("Cart_screen restaurant_name: ${widget.restaurant[1]}");
    super.initState();
  }

// [1, Restaurant0, 0xc2458e81a94e8d477fe1ca03eb3b083a49c55529, 1、2、3、4, http://210.70.80.14/images/restaurant0.jpg, restaurant0 introduction, restaurant0 type]
// restaurant[0] = id
// restaurant[1] = restaurant name
// restaurant[2] = blockchain address
// restaurant[3] = menu id
// restaurant[4] = image url

  @override
  Widget build(BuildContext context) {

    var cart = context.watch<CartModel>();
    // final transferStore = useWalletTransfer(context);
    final NetworkType network = NetworkType.Local;
    final _contractLocator = Provider.of<ContractLocator>(context);
    final _configurationService = Provider.of<ConfigurationService>(context);
    final _cartModel = Provider.of<CartModel>(context);

    cart.calculateTotal();
    double totalPrice = cart.totalCartValue;
    final now = DateTime.now();
    final List<String> items = [
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 5))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 10))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 15))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 20))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 25))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 30))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 35))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 40))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 45))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 50))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 55))).toString(),
      DateFormat('MM/dd kk點mm分').format(now.add(const Duration(minutes: 60))).toString(),
    ];
    String? selectedValue;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          // 'Cart (${cart.cart.length})',
          "Cart (${_cartModel.cart.length})"
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index < cart.cart.length) {
            final product = cart.cart[index];
            return _buildCartItem(product, cart);
          }
          return Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Cost',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (cart.cart.length>=1)
                    Text(
                      '取餐時間',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    if (cart.cart.length>=1)
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
                                    // print(selectedValue);
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
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Colors.grey,
          );
        },
        itemCount: cart.cart.length + 1,
      ),
      bottomSheet: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () async {

              // var application_name = await GetApplicationName.get_application_name(applicationId: '987654321');
              // if(application_name=="" || application_name==null){
              //   print("ID not exist");
              // }else{
              //   print("Cart Screen ApplicationName: ${application_name}");
              // }
              //
              // var second_oauth_result = await SecondOauth.second_oauth_post('2h9iCnKEVUzvBpr7pUUnqHNRCvYyjZQ2fHBcqZ7Aea');
              // print("Cart Screen SecondOauthResult: ${second_oauth_result}");

              if(cart.cart.length>=1){
                //**************************
                final privateKey = _configurationService.getPrivateKey();
                final credentials = EthPrivateKey.fromHex(privateKey!);
                final from_address = await credentials.extractAddress();
                final client = Web3Client(rpcUrl, Client());
                final networkId = await client.getNetworkId();
                final contract =
                DeployedContract(ContractAbi.fromJson('[{"inputs":[{"internalType":"uint256","name":"initialSupply","type":"uint256"}],"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"spender","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"spender","type":"address"}],"name":"allowance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"approve","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"subtractedValue","type":"uint256"}],"name":"decreaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"addedValue","type":"uint256"}],"name":"increaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"},{"inputs":[{"internalType":"address","name":"from","type":"address"},{"internalType":"address","name":"to","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transferFrom","outputs":[{"internalType":"bool","name":"","type":"bool"}],"stateMutability":"nonpayable","type":"function"}]', 'name'), EthereumAddress.fromHex("0x513703514adf8c14ab8b1db2bc3fbc06341c26c1"));
                final transfer = contract.function('transfer');

                final contractService = _contractLocator.getInstance(NetworkType.Local);
                final tokenBalance = await contractService
                    .getTokenBalance(from_address);

                // dialog pay money
                showPayment(tokenBalance.toString(), totalPrice.round().toString(), client,
                    credentials, contract, transfer, networkId, cart.cart, selectedValue!);

              }
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            child: Text(
              'CHECKOUT',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }


  void showPayment(String tokenBalance, String tokenPayment, Web3Client client, EthPrivateKey credentials,
      DeployedContract contract, ContractFunction contract_function, int networkId, List cart_list, String pick_up_time){
    showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('確認付錢'),
          content: Text('目前持有的token: ${tokenBalance}\n此次交易需要的token: ${tokenPayment}\n'
                        '交易後剩餘: ${int.parse(tokenBalance)-int.parse(tokenPayment)}'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('確認'),
              onPressed: () async {
                //*********************
                if(int.parse(tokenBalance)>= int.parse(tokenPayment)){
                //   final transactionID = await client.sendTransaction(
                //     credentials,
                //     Transaction.callContract(
                //       contract: contract,
                //       function: contract_function,
                //       parameters: [EthereumAddress.fromHex(restaurants[restaurant_id].blockchain_address!), BigInt.from(int.parse(tokenPayment))],
                //       // nonce: await client.getTransactionCount(from, atBlock: BlockNum.pending()),
                //       maxGas: 70000000,
                //     ),
                //     chainId: networkId,
                //   );
                  print("CartScreen: ${cart_list[0].name}");
                  List<Map> map_list =[];
                  for (var i=0;i<cart_list.length;i++){
                    Map<String, String> map_product = {
                      'restaurant_name':widget.restaurant[1],
                      'product_name':cart_list[i].name,
                      'quantity':cart_list[i].qty.toString(),
                      'price':cart_list[i].price.toString(),
                    };
                    map_list.add(map_product);
                  }
                  String order_content_json = jsonEncode(map_list);

                  Order.order_post(widget.restaurant[1], "105021019", "customer_name",
                      order_content_json, pick_up_time, "0");

                  // Order.order_post(widget.restaurant[1], "105021019", "customer_name",
                  //     '[{"a":1, "b":2}]', pick_up_time, "0");

                  // Navigator.of(context).popUntil((route) => route.isFirst);
                  // Navigator.of(context).popAndPushNamed('/');
                }else{
                  final snackBar = SnackBar(
                    content: const Text('金額不足'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
