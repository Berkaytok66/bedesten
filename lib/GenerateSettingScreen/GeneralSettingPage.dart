import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Thema/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralSettingPage extends StatefulWidget {
  const GeneralSettingPage({Key? key}) : super(key: key);

  @override
  State<GeneralSettingPage> createState() => _GeneralSettingPageState();
}

class _GeneralSettingPageState extends State<GeneralSettingPage> {
  bool light1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("GeneralSettings.GeneralSettingsTitle")),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
        ),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(AppLocalizations.of(context).translate("GeneralSettings.ThemesSettings")),
            secondary: Icon(Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark ? Icons.nightlight_round : Icons.sunny),
            value: Provider.of<ThemeProvider>(context).themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              // Provider'ı kullanarak tema değişikliğini uygula.
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme(value);
              // Switch'in durumunu güncellemek için ekranı yenile
              setState(() {});
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
