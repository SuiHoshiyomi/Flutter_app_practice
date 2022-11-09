import 'package:etherwallet/service/address_service.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/service/contract_locator.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'model/cart.dart';
import 'package:etherwallet/Shops/restaurant/models/cart.dart';

import 'components/requests/restaurant_info_request.dart';
// import 'model/catalog.dart';

Future<List<SingleChildWidget>> createProviders() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  final configurationService = ConfigurationService(sharedPrefs);

  final addressService = AddressService(configurationService);

  final contractLocator = await ContractLocator.setup();

  return [
    Provider.value(value: addressService),
    Provider.value(value: contractLocator),
    Provider.value(value: configurationService),
    ChangeNotifierProvider(create: (context) => CartModel(),),
    // ChangeNotifierProxyProvider<CatalogModel, CartModel>(
    //   create: (context) => CartModel(),
    //   update: (context, catalog, cart) {
    //     if (cart == null) throw ArgumentError.notNull('cart');
    //     cart.catalog = catalog;
    //     return cart;
    //   },
    // ),
  ];
}
