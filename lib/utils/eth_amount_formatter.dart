import 'package:web3dart/web3dart.dart';
import 'dart:math' as math;

class EthAmountFormatter {
  EthAmountFormatter(this.amount);

  final BigInt? amount;
  String format({
    EtherUnit fromUnit = EtherUnit.wei,
    EtherUnit toUnit = EtherUnit.ether,
  }) {
    if (amount == null) {
      return '-';
    }

    BigInt bigNum = amount! * BigInt.from(math.pow(10, 18));

    return EtherAmount.fromUnitAndValue(fromUnit, bigNum)
        .getValueInUnit(toUnit)
        .toString();
  }
}
