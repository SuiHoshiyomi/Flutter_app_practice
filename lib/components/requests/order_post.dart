import 'dart:convert';

import 'package:http/http.dart' as http;

class Order {
  static Future<bool> order_post(String restaurant_name, String customer_id, String customer_name,
      String order_content, String pick_up_time, String status,) async {

    DateTime now = DateTime.now();

    restaurant_name = "\'" + restaurant_name + "\'";
    customer_id = "\'" + customer_id + "\'";
    customer_name = "\'" + customer_name + "\'";
    order_content = '\'' + order_content + '\'';  //[{"a":1, "b":2}]
    pick_up_time = "\'" + now.year.toString() + "-" + pick_up_time.replaceAll("點", ":").replaceAll("分", "").replaceAll("/", "-") + "\'";    //2022-10-17 09:53:28
    String order_time = "\'" + now.toString() + "\'";    //2022-10-16 15:03:19
    status = "\'" + status + "\'";

    var client = http.Client();
    try {
      var url = Uri.parse('http://210.70.80.14/new_order.php');
      var response = await http.post(url, body: {"restaurant_name": restaurant_name,
        "customer_id": customer_id, "customer_name": customer_name, "order_content": order_content,
        "pick_up_time": pick_up_time, "order_time": order_time, "status": status});

      print(response.statusCode);
      var response_body = utf8.decode(response.bodyBytes);
      print(response_body);
      // print("restaurant_info_request response: ${response.statusCode}");
      // print("restaurant_info_request length: ${response_body.take((response_body.length-1)).toList()}");
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      // print(response_body.take((response_body.length-1)).toList());
      // return response_body.take((response_body.length-1)).toList();
      return true;
    } finally {
      client.close();
      return false;
    }
  }
}
