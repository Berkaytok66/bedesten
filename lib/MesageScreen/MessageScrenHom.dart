import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:bedesten/MesageScreen/MesageModel/MesageModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageScrenHom extends StatelessWidget {
  const MessageScrenHom({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate("MessagesMainPage.Messages"),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 300,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: (AppLocalizations.of(context).translate("MessagesMainPage.SearchMyMessages")),
                              hintStyle: TextStyle(color:Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.black54,), // hintText için stil
                              border: InputBorder.none
                          ),
                          style: TextStyle(color: Colors.black), // Girilen metin rengi
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search_sharp,
                      color: Colors.blue,
                    )

                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: MesageModel.k_list.length,//toplam mesaj
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){

                    },
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(
                        MesageModel.k_list[index].k_Image,
                      ),
                    ),
                    title: Text(
                      MesageModel.k_list[index].k_name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    subtitle: Text("Son mesaj",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.hintColor
                      ),
                    ),
                    trailing: Text("13.10.2023",
                    style: TextStyle(
                      fontSize: 12,
                        color: theme.hintColor
                    ),),
                  );
                })
          ],
        ),
      ),
    );
  }
}
