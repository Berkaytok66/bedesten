import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/wigets/FavoriteMarketWidget.dart';
import 'package:flutter/material.dart';

import '../wigets/FavoriteUrunWidget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  int _ButtonIndex=0;

  final _scheudleWidget = [
    FavoriteUrunWidget(),
    FavoriteMarketWidget()//Widget yazılması gerek
  ];
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("FavoriteScreen.MyFavorites"),
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,
          ),
        ),
        // AppBar'ın geri kalan özelliklerini ayarlayabilirsiniz.
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.white,
        actions: [
          // Diğer action widget'ları buraya eklenebilir.
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3,),
            Container(

              decoration: BoxDecoration(
                color:  Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.white,

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          _ButtonIndex =0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width/50,horizontal: MediaQuery.of(context).size.height/15),
                        decoration: BoxDecoration(
                          color: _ButtonIndex == 0 ? Colors.green : Colors.transparent,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                        ),
                        child: Text(AppLocalizations.of(context).translate("FavoriteScreen.Favorite_Products"),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,

                        ),),
                      ),
                    ),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _ButtonIndex =1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.width/50,
                          horizontal: MediaQuery.of(context).size.height/15),
                      decoration: BoxDecoration(
                        color: _ButtonIndex == 1 ? Colors.green : Colors.transparent,
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                      ),
                      child: Text(AppLocalizations.of(context).translate("FavoriteScreen.Favorite_Markets"),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                        ),),
                    ),
                  )
                ],
              ),
            ),

            _scheudleWidget[_ButtonIndex],
          ],
        ),
      ),
    );
  }
}
