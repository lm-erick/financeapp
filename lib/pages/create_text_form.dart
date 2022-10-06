import 'package:finances/controller/utils_controller.dart';
import 'package:flutter/material.dart';

class CreateTextForm {
  final UtilsController controller = UtilsController();

  TextFormField createTextFormFieldNumber(TextEditingController controllerText,
      String label, String mask, int length) {
    return TextFormField(
      controller: controllerText,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      inputFormatters: [controller.formaterMask(mask)],
      validator: (value) {
        if (value?.length.compareTo(length) != 0) return controller.LACK_CHAR;
        String result = controller.validateNullField(value);
        return result.isEmpty ? null : result;
      },
    );
  }

  TextFormField createTextFormFieldEmail(
      TextEditingController controllerText, String label) {
    return TextFormField(
      controller: controllerText,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        if (!controller.isValidEmail(value)) return controller.EMAIL_INVALID;
        String result = controller.validateNullField(value);
        return result.isEmpty ? null : result;
      },
    );
  }

  TextFormField createTextFormFieldText(
      TextEditingController controllerText, String label) {
    return TextFormField(
      controller: controllerText,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        String result = controller.validateNullField(value);
        return result.isEmpty ? null : result;
      },
    );
  }

  TextFormField createTextFormFieldPassword(
      TextEditingController controllerText, String label) {
    return TextFormField(
      controller: controllerText,
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        String result = controller.validateNullField(value);
        return result.isEmpty ? null : result;
      },
    );
  }
}
