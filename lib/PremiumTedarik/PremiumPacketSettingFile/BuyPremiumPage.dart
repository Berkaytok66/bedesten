import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/PremiumTedarik/PremiumPacketSettingFile/BuyControllerClass.dart';
import 'package:flutter/material.dart';



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Service Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BuyPremiumPage(),
    );
  }
}

class BuyPremiumPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BuyControllerClass buyControllerClass  = BuyControllerClass();
    buyControllerClass.checkBuyControllerStatus();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("BuyPremiumPage.Premium_Package")),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
        ),
      ),
      body: ListView(
        children: <Widget>[
          PremiumFeatureCard(),
          FeatureListTile(
            iconData: Icons.check_circle_outline,
            featureTitle: AppLocalizations.of(context).translate("BuyPremiumPage.Shop"),
            featureDescription: AppLocalizations.of(context).translate("BuyPremiumPage.Store_description"),

          ),
          SizedBox(height: 10,),
          FeatureListTile(
            iconData: Icons.check_circle_outline,
            featureTitle: AppLocalizations.of(context).translate("BuyPremiumPage.Repair"),
            featureDescription: AppLocalizations.of(context).translate("BuyPremiumPage.Repair_description"),
          ),
          FeatureListTile(
            iconData: Icons.check_circle_outline,
            featureTitle: AppLocalizations.of(context).translate("BuyPremiumPage.Remove_ads"),
            featureDescription: AppLocalizations.of(context).translate("BuyPremiumPage.Remove_ads_description"),
          ),
          FeatureListTile(
            iconData: Icons.check_circle_outline,
            featureTitle: AppLocalizations.of(context).translate("BuyPremiumPage.Silver_Badge"),
            featureDescription: AppLocalizations.of(context).translate("BuyPremiumPage.Silver_Badge_info"),
          ),
          PricingOptions(),
          Bottomtext(),
        ],
      ),
    );
  }
}

class PremiumFeatureCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BuyControllerClass buyControllerClass  = BuyControllerClass();
    buyControllerClass.checkBuyControllerStatus();
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Bedesten',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff6892d0),
                        Color(0xFFC2BCBC),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Premium',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(buyControllerClass.hasBoughtPremium
                ? ""
                : AppLocalizations.of(context).translate("BuyPremiumPage.Premium_Package_info")),
          ],
        ),
      ),
    );
  }
}

class FeatureListTile extends StatelessWidget {
  final IconData iconData;
  final String featureTitle;
  final String featureDescription;

  const FeatureListTile({
    Key? key,
    required this.iconData,
    required this.featureTitle,
    required this.featureDescription,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(featureTitle),
      subtitle: Text(featureDescription,style: TextStyle(fontSize: 15),),
      iconColor: Colors.blue,

    );
  }
}

class PricingOptions extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BuyControllerClass buyControllerClass = BuyControllerClass();
    buyControllerClass.checkBuyControllerStatus();
    if (buyControllerClass.hasBoughtPremium){
      return Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(AppLocalizations.of(context).translate("BuyPremiumPage.Premium_Package_info_pro")),
              SizedBox(height: 16),
              CustomButton(
                title: AppLocalizations.of(context).translate("BuyPremiumPage.Monthly"),
                price: '49.00TRY / ${AppLocalizations.of(context).translate("BuyPremiumPage.month")}',
                onTap: (){
                  print("object");
                },
              ),
              // Add more buttons as needed
            ],
          ),
        ),
      );
    }else{
      return Card(
        margin: EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Text(AppLocalizations.of(context).translate("BuyPremiumPage.package_information")),
              SizedBox(height: 16),
              CustomButton(
                title: AppLocalizations.of(context).translate("BuyPremiumPage.Monthly"),
                price: '49.00TRY / ${AppLocalizations.of(context).translate("BuyPremiumPage.month")}',
                onTap: (){
                  print("object");
                },
              ),
              SizedBox(height: 10,),
              CustomButton(
                title: AppLocalizations.of(context).translate("BuyPremiumPage.Monthly"),
                price: '49.00TRY / ${AppLocalizations.of(context).translate("BuyPremiumPage.month")}',
                onTap: (){
                  print("object");
                },
              ),
              SizedBox(height: 10,),
              CustomButton(
                title: 'Aylık Plan',
                price: '49.00TRY / ${AppLocalizations.of(context).translate("BuyPremiumPage.month")}',
                onTap: (){
                  print("object");
                },
              ),

              // Add more buttons as needed
            ],
          ),
        ),
      );
    }

  }
}


class CustomButton extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onTap;

  const CustomButton({required this.title, required this.price,required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(200)
                  ),
                ),
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  child: Text(
                    price,
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Bottomtext extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BuyControllerClass buyControllerClass = BuyControllerClass();
    buyControllerClass.checkBuyControllerStatus();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40,),
        Text(AppLocalizations.of(context).translate("BuyPremiumPage.iptal_txt")

        ),
      ],
    );
  }
}
