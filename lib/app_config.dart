import 'package:etherwallet/model/network_type.dart';
import 'package:etherwallet/utils/wallet_icons.dart';
import 'package:flutter/material.dart';

// ignore: avoid_classes_with_only_static_members
class AppConfig {
  static Map<NetworkType, AppConfigParams> networks =
      <NetworkType, AppConfigParams>{
    // NetworkType.Local: AppConfigParams(
    //   'http://192.168.18.16:22000',
    //   // '0xe0E3C7ece2AF749e25A2bC215E4D6dc02f24c931',
    //   '0x513703514adf8c14ab8b1db2bc3fbc06341c26c1',
    //   web3RdpUrl: 'ws://192.168.18.16:22005',
    //   symbol: 'AUM',
    //   faucetUrl: 'about:blank',
    //   enabled: true,
    //   label: 'AUMoney',
    // ),
    NetworkType.Local: AppConfigParams(
      'http://210.70.80.14:22000',
      // '0xe0E3C7ece2AF749e25A2bC215E4D6dc02f24c931',
      '0x32A29E831Dc8b7561c2677AD505fd27d49eDA235',
      web3RdpUrl: 'ws://210.70.80.14:22005',
      symbol: 'AUM',
      faucetUrl: 'about:blank',
      enabled: true,
      label: 'AUMoney',
    ),
    NetworkType.Ethereum: AppConfigParams(
      'https://ropsten.infura.io/v3/628074215a2449eb960b4fe9e95feb09',
      '0x5060b60cb8Bd1C94B7ADEF4134555CDa7B45c461',
      web3RdpUrl:
          'wss://ropsten.infura.io/ws/v3/628074215a2449eb960b4fe9e95feb09',
      symbol: 'ETH',
      faucetUrl: 'https://faucet.ropsten.be',
      enabled: true,
      icon: WalletIcons.ethereum,
      label: 'Ethereum (Ropsten)',
    ),
    NetworkType.BSC: AppConfigParams(
      'https://data-seed-prebsc-1-s1.binance.org:8545',
      '0x73434bb95eC80d623359f6f9d7b84568407187BA',
      symbol: 'BNB',
      faucetUrl: 'https://testnet.binance.org/faucet-smart',
      enabled: true,
      label: 'Binance Chain (BSC)',
    ),
    NetworkType.Matic: AppConfigParams(
      'https://rpc-mumbai.maticvigil.com',
      '0x73434bb95eC80d623359f6f9d7b84568407187BA',
      web3RdpUrl: 'wss://ws-mumbai.matic.today',
      symbol: 'MATIC',
      faucetUrl: 'https://faucet.matic.network',
      enabled: true,
      label: 'Matic (Mumbai)',
    )
  };
}

class AppConfigParams {
  AppConfigParams(
    this.web3HttpUrl,
    this.contractAddress, {
    required this.symbol,
    required this.faucetUrl,
    required this.enabled,
    required this.label,
    this.web3RdpUrl,
    this.icon = WalletIcons.coins,
  });
  final String? web3RdpUrl;
  final String web3HttpUrl;
  final String contractAddress;
  final String symbol;
  final String faucetUrl;
  final IconData icon;
  final bool enabled;
  final String label;
}
