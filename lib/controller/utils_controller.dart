import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UtilsController {
  final String EMPTY_FIELD = 'Por favor preencha o campo!';
  final String LACK_CHAR = 'Faltando caracteres';
  final String EMAIL_INVALID = 'E-mail inválido!';

  void showToast(String mensagem) {
    Fluttertoast.showToast(
        msg: mensagem,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);
  }

  bool isValidEmail(value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  String validateNullField(value) {
    if (value != null && !value.isEmpty) return '';

    return EMPTY_FIELD;
  }

  MaskTextInputFormatter formaterMask(String validation) {
    return MaskTextInputFormatter(
        mask: validation,
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }

  CurrencyTextInputFormatter moneyFormater() {
    return CurrencyTextInputFormatter(
        locale: 'br', decimalDigits: 2, symbol: '', turnOffGrouping: true);
  }
}
