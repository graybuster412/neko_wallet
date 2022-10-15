import 'package:neko_wallet/utils/utils.dart';

class CreditCardViewModel {
  final String currency;
  final String cardNumber;
  final String cardHolder;
  final String expiredDate;

  final String type;
  final String currencyType;

  CreditCardViewModel({
    required this.currency,
    required this.type,
    required this.cardNumber,
    required this.cardHolder,
    required this.expiredDate,
    required this.currencyType,
  });

  String formattedCurrency() {
    return formatCurrency(currency: currency) ?? '\$0,0';
  }

  String formattedExpiredDate(String format) {
    return formatDateWith(expiredDate, format);
  }

  String formattedCardNumber() {
    final String trimCardNumberRegex = cardNumber
        .replaceAll(new RegExp(r'/\s+/g'), '')
        .replaceAll(new RegExp(r'/[^0-9]/gi'), '')
        .replaceAll(new RegExp(r'\d(?!\d{0,3}$)'), '*');
    final regex = RegExp(r'(.{4})(?!$)');
    final creditCardNumber =
        trimCardNumberRegex.replaceAllMapped(regex, (m) => '${m[0]}     ');

    return creditCardNumber;
  }
}
