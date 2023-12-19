import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/Screens/SettingScrenn/AboutUsSettinFullPage/CommunicationPage.dart';
import 'package:bedesten/Screens/SettingScrenn/AboutUsSettinFullPage/PrivacyPolicyPage.dart';
import 'package:bedesten/Screens/SettingScrenn/AboutUsSettinFullPage/TermsOfServicePage.dart';
import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  late List<Map<String, dynamic>> localizedItems;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Yerelleştirmeyi didChangeDependencies içinde yapıyoruz çünkü burası, context'in tamamen
    // oluştuğu ve yerelleştirme işleminin yapılmasına izin verecek ilk noktadır.
    localizedItems = [
      {
        'title': AppLocalizations.of(context).translate('AboutUsPage.Privacy_Policy'),
        'pageBuilder': () => const PrivacyPolicyPage(),
      },
      {
        'title': AppLocalizations.of(context).translate('AboutUsPage.Terms_of_Use'),
        'pageBuilder': () => const TermsOfServicePage(),
      },
      {
        'title': AppLocalizations.of(context).translate('AboutUsPage.Contact_information'),
        'pageBuilder': () => const CommunicationPage(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    // AppBar başlığını yerelleştirme işlemi
    String aboutUsTitle = AppLocalizations.of(context).translate("AboutUsPage.About");

    return Scaffold(
      appBar: AppBar(
        title: Text(aboutUsTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: localizedItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(localizedItems[index]['title']),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => localizedItems[index]['pageBuilder'](),
                    ),
                  );
                },
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }

}
