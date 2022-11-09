import 'package:etherwallet/Shops/restaurant/screens/cart_screen.dart';
import 'package:etherwallet/Shops/restaurant/screens/restaurant_introduction_screen.dart';
import 'package:etherwallet/app_main_page.dart';
import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/qrcode_reader_page.dart';
import 'package:etherwallet/service/configuration_service.dart';
import 'package:etherwallet/utils/route_utils.dart';
import 'package:etherwallet/wallet_create_page.dart';
import 'package:etherwallet/wallet_import_page.dart';
import 'package:etherwallet/wallet_main_page.dart';
import 'package:etherwallet/wallet_transfer_page.dart';
// import 'package:etherwallet/context/screen/cart.dart';
// import 'package:etherwallet/context/screen/catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'Shops/restaurant/screens/home_screen.dart';
// import 'components/shopContainer/restaurant_catalog.dart';
// import 'context/screen/carouselslider.dart';
import 'context/setup/wallet_setup_provider.dart';
import 'context/transfer/wallet_transfer_provider.dart';
import 'context/wallet/wallet_provider.dart';
import 'intro_page.dart';
import 'login_page.dart';

Map<String, WidgetBuilder> getRoutes(context) {
  return {
    '/': (BuildContext context) {
      final configurationService = Provider.of<ConfigurationService>(context);
      if (configurationService.didSetupWallet())
        return WalletProvider(
            // ignore: prefer_const_constructors
            builder: (context, store) => HomeScreen());
        // return WalletProvider(
        //     // ignore: prefer_const_constructors
        //     builder: (context, store) => WalletMainPage('Your wallet'));

      return const IntroPage();
    },
    '/create': (BuildContext context) =>
        WalletSetupProvider(builder: (context, store) {
          useEffect(() {
            store.generateMnemonic();
          }, []);

          // ignore: prefer_const_constructors
          return WalletCreatePage('Create wallet');
        }),
    '/import': (BuildContext context) => WalletSetupProvider(
          // ignore: prefer_const_constructors
          builder: (context, store) => WalletImportPage('Import wallet'),
        ),
    '/transfer': (BuildContext context) => WalletTransferProvider(
          // ignore: prefer_const_constructors
          builder: (context, store) => WalletTransferPage(
            title: 'Send Tokens',
            network: getRouteArgs<NetworkType>(context),
          ),
        ),
    '/qrcode_reader': (BuildContext context) => QRCodeReaderPage(
          title: 'Scan QRCode',
          onScanned: ModalRoute.of(context)?.settings.arguments as OnScanned?,
        ),
    '/login': (context) => SignInPage(),
    // '/login': (BuildContext context) {
    //   final configurationService = Provider.of<ConfigurationService>(context);
    //   if (!configurationService.didLogin())
    //     return SignInPage();
    //
    //   if (configurationService.didSetupWallet())
    //     return WalletProvider(
    //       // ignore: prefer_const_constructors
    //         builder: (context, store) => HomeScreen());
    //
    //   return const IntroPage();
    // },
    '/wallet_main_page': (BuildContext context) {
      final configurationService = Provider.of<ConfigurationService>(context);
      if (configurationService.didSetupWallet())
        return WalletProvider(
          // ignore: prefer_const_constructors
            builder: (context, store) => WalletMainPage("My Wallet"));
      // return WalletProvider(
      //     // ignore: prefer_const_constructors
      //     builder: (context, store) => WalletMainPage('Your wallet'));

      return const IntroPage();
    },
    '/restaurant_introduction_page': (context) => RestaurantIntroductionScreen(),
    // '/cart_screen': (context) => CartScreen(),
    '/cart_screen': (BuildContext context) => CartScreen(
      restaurant: ModalRoute.of(context)?.settings.arguments as List,
    ),

    // '/shopslider': (context) => ShopPage(),
    // '/catalog': (context) => const MyCatalog(),
    // '/cart': (context) => const MyCart(),
    // '/restaurant_catalog': (context) => restaurant_catalog(),
    // '/shop_restaurant': (context) => HomeScreen(),
    // '/login': (BuildContext context) => LoginDemo()
  };
}
