import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_test/auth/auth_error.dart';
import 'package:flutter_bloc_test/dialogs/generic_dialog.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionBuilder: () => {
      'Ok': true,
    },
  );
}
