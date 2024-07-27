import 'package:flutter/material.dart';
import 'package:gibt_1/models/account.dart';
import 'package:gibt_1/providers/account_characters_provider.dart';
import 'package:gibt_1/providers/accounts_provider.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountsProvider =
        Provider.of<AccountsProvider>(context, listen: true);
    final accounts = accountsProvider.list;

    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        height: 500,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Accounts List"),
              ListView.builder(
                  itemCount: accounts.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _ContextMenuDemo(
                      account: accounts[index],
                    );
                  }),
              const Row(
                children: [
                  Text("App version"),
                  Spacer(),
                  AppVersionViewer(),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // backgroundColor: Colors.indigo,
        onPressed: () {
          Account account = Account(name: "", server: "NA", isActive: false);
          openCreateDialog(context, account);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Future openCreateDialog(BuildContext context, Account account) {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => AccountFormDialog(
              account: account,
            ));
  }
}

class AppVersionViewer extends StatefulWidget {
  const AppVersionViewer({
    super.key,
  });

  @override
  State<AppVersionViewer> createState() => _AppVersionViewerState();
}

class _AppVersionViewerState extends State<AppVersionViewer> {
  String? appVersion;
  String? appBuildName;

  @override
  void initState() {
    // TODO: implement initState
    _getAppInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (appVersion != null && appBuildName != null)
        ? Text("$appVersion+$appBuildName")
        : const Text('...');
  }

  void _getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      appVersion = packageInfo.version;
      appBuildName = packageInfo.buildNumber;
    });
  }
}

// Pressing the PopupMenuButton on the right of this item shows
// a simple menu with one disabled item. Typically the contents
// of this "contextual menu" would reflect the app's state.
class _ContextMenuDemo extends StatelessWidget {
  const _ContextMenuDemo({Key? key, required this.account}) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    final accountsProvider =
        Provider.of<AccountsProvider>(context, listen: false);
    final accountCharactersProvider =
        Provider.of<AccountCharactersProvider>(context, listen: false);

    return ListTile(
      leading: account.isActive
          ? const Icon(
              Icons.check,
              color: Colors.green,
            )
          : const Icon(Icons.check),
      title: Text(account.name),
      subtitle: Text("Server: ${account.server}"),
      onTap: () async {
        await accountsProvider.select(account);
        await accountCharactersProvider.all();
      },
      trailing: PopupMenuButton<String>(
        padding: EdgeInsets.zero,
        onSelected: (value) {
          if (value == 'edit') {
            openEditDialog(context, account);
          } else if (value == 'delete') {
            openConfirmDeleteDialog(context, account);
          }
        },
        itemBuilder: (context) => <PopupMenuItem<String>>[
          const PopupMenuItem<String>(
            value: "edit",
            child: ListTile(
              title: Text("Edit"),
              trailing: Icon(Icons.edit),
            ),
          ),
          PopupMenuItem<String>(
            value: "delete",
            enabled: account.isActive ? false : true,
            child: const ListTile(
              title: Text("Delete"),
              trailing: Icon(Icons.delete),
            ),
          ),
        ],
      ),
    );
  }

  Future openConfirmDeleteDialog(BuildContext context, Account account) {
    return showDialog(
        context: context,
        builder: (context) => ConfirmDeleteAccountDialog(
              account: account,
            ));
  }

  Future openEditDialog(BuildContext context, Account account) {
    return showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) => AccountFormDialog(
              account: account,
            ));
  }
}

class AccountFormDialog extends StatefulWidget {
  const AccountFormDialog({super.key, required this.account});
  final Account account;

  @override
  State<AccountFormDialog> createState() => _AccountFormDialogState();
}

class _AccountFormDialogState extends State<AccountFormDialog> {
  late TextEditingController accountNameTextController;
  late String accountServer;

  List<String> serversList = ["NA", "EU", "AS", "TW"];

  @override
  void initState() {
    super.initState();
    accountNameTextController = TextEditingController();
    // ignore: unrelated_type_equality_checks
    if (widget.account.name != Null) {
      accountNameTextController.text = widget.account.name;
    }
    accountServer = "NA";
    // ignore: unrelated_type_equality_checks
    if (widget.account.server != Null) {
      accountServer = widget.account.server;
    }
  }

  @override
  void dispose() {
    accountNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accountsProvider =
        Provider.of<AccountsProvider>(context, listen: false);

    return AlertDialog(
      title: const Text("Account Form"),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: 'Enter Account Name'),
              controller: accountNameTextController,
            ),
            Container(
              decoration: BoxDecoration(
                  border: BorderDirectional(
                      bottom: BorderSide(
                          color: Colors.black.withAlpha(150), width: 1))),
              child: DropdownButton(
                  autofocus: true,
                  hint: const Text("Select Server"),
                  isExpanded: true,
                  underline: const SizedBox(),
                  value: accountServer,
                  items: serversList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      accountServer = newValue!;
                    });
                  }),
            )
            // TextField(
            //   decoration: InputDecoration(hintText: 'Select Server'),
            // ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close")),
        TextButton(
            onPressed: () {
              if (accountNameTextController.text.isEmpty) return;
              Navigator.of(context).pop();
              widget.account.name = accountNameTextController.text;
              widget.account.server = accountServer;
              if (widget.account.id == null) {
                accountsProvider.store(widget.account);
              } else {
                accountsProvider.update(widget.account);
              }
            },
            child: const Text("Save"))
      ],
    );
  }
}

class ConfirmDeleteAccountDialog extends StatelessWidget {
  const ConfirmDeleteAccountDialog({super.key, required this.account});
  final Account account;

  @override
  Widget build(BuildContext context) {
    final accountsProvider =
        Provider.of<AccountsProvider>(context, listen: false);

    return AlertDialog(
      title: const Text("Delete ccount?"),
      content: Text(
          'Are you sure to delete the account "${account.name}" in server "${account.server}"?.'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No")),
        TextButton(
            onPressed: () {
              accountsProvider.delete(account);
              Navigator.of(context).pop();
            },
            child: const Text("Yes"))
      ],
    );
  }
}
