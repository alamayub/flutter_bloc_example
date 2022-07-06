import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_test/dialogs/generic_dialog.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: 'Delete Account',
    content:
        'Are you sure you want to delete your account? You can not undo this operation!',
    optionBuilder: () => {
      'Cancel': false,
      'Delete Account': true,
    },
  ).then((value) => value ?? false);
}
