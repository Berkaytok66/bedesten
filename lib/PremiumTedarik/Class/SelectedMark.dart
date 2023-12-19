import 'package:bedesten/PremiumTedarik/Class/BrandModels.dart';
import 'package:bedesten/PremiumTedarik/Class/SelectedModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../AppLocalizations/AppLocalizations.dart';
import '../../Screens/HomeScreenFile/design_course_app_theme.dart';

class SelectedMark extends StatefulWidget {
  const SelectedMark({super.key});

  @override
  State<SelectedMark> createState() => _SelectedMarkState();
}

class _SelectedMarkState extends State<SelectedMark> {
  BrandModels brandModels = BrandModels();
  List<String> allItems = []; // Örnek marka listesi
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    someFunction();
  }

  void someFunction() async {
    await brandModels.loadData();

    List<String> allBrands = brandModels.getBrands();
    print(allBrands); // Tüm markaları yazdırır

    setState(() {
      allItems = allBrands; // allItems listesini allBrands listesi ile güncelle
      searchResults = allBrands; // Başlangıçta tüm sonuçları göster
    });
  }
  void updateSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = allItems;
      });
    } else {
      query = query.toLowerCase();
      setState(() {
        searchResults = allItems.where((item) => item.toLowerCase().contains(query)).toList();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cihaz Markası Seçin"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getSearchBarUI(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  // Diğer widget özellikleri buraya eklenebilir
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectedModel(Marka: searchResults[index],)),
                    );

                    // Burada başka işlemler de yapabilirsiniz, örneğin başka bir sayfaya geçiş vs.
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.92,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context) == Brightness.dark ? Colors.white38 : Colors.black12,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignCourseAppTheme.darkerText,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).translate("SelectedModel.Search_for_brand"),
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFB9BABC),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Color(0xFFB9BABC),

                            ),
                          ),
                          onChanged: (value){
                            setState(() {
                              updateSearchResults(value);
                            });
                          },
                          onEditingComplete: () {},//Kullanıcı metni gitdikden sonra enter tuşu ile arama işrevi buraya eklenecek
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/6,
                      height: MediaQuery.of(context).size.height,
                      child: Icon(CupertinoIcons.search, color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black,),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

}
