import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/bloc/app_bloc.dart';
import 'package:flutter_bloc_test/bloc/app_event.dart';
import 'package:flutter_bloc_test/dialogs/delete_account_dialog.dart';
import 'package:flutter_bloc_test/dialogs/logout_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupMenuButton extends StatelessWidget {
  const MainPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuAction>(
      onSelected: (value) async {
        switch (value) {
          case MenuAction.logout:
            final shouldLogout = await showLogoutDialog(context);
            if (shouldLogout) {
              // ignore: use_build_context_synchronously
              context.read<AppBloc>().add(const AppEventLogout());
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showDeleteAccountDialog(context);
            if (shouldDeleteAccount) {
              // ignore: use_build_context_synchronously
              context.read<AppBloc>().add(const AppEventDeleteAccount());
            }
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<MenuAction>(
            value: MenuAction.logout,
            child: Text('Log out'),
          ),
          const PopupMenuItem<MenuAction>(
            value: MenuAction.deleteAccount,
            child: Text('Delete Account'),
          )
        ];
      },
    );
  }
}
