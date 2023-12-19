import 'dart:io';
import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class EklePage extends StatefulWidget {
  const EklePage({Key? key}) : super(key: key);

  @override
  _EklePageState createState() => _EklePageState();
}

class _EklePageState extends State<EklePage> {
  final List<String?> _imagePaths = [null];
  final TextEditingController _controllerModel = TextEditingController();
  final TextEditingController _controllerIlan = TextEditingController();
  final TextEditingController _controllerInfo = TextEditingController();
  String? selectedText;
  String? selectedTextRenk;
  Future<void> _addImage(BuildContext context, ImageSource source) async {
    if (_imagePaths.length >= 8) {
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      setState(() {

        _imagePaths.insert(_imagePaths.length - 1, image.path);
        _cropImage(image.path);
      });
    }
  }

  Future<void> _cropImage(String path) async {
    CroppedFile? croppedFile = (await ImageCropper().cropImage(
      sourcePath: path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
      uiSettings: [
        AndroidUiSettings(
        toolbarTitle: AppLocalizations.of(context).translate("EklePage.Crop_Selected_Image"),
        toolbarColor: Colors.blue.shade200,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
        IOSUiSettings(
          title: AppLocalizations.of(context).translate("EklePage.Crop_Selected_Image"),
        ),
        WebUiSettings(
          context: context,
        ),
      ]
    )) as CroppedFile?;

    if (croppedFile != null) {
      setState(() {
        int index = _imagePaths.indexOf(path);
        if (index != -1) {
          _imagePaths[index -1] = croppedFile.path;
        } else {
          _imagePaths.add(croppedFile.path);

        }

      //  Navigator.of(context).pop();
      });
    }

  }

  void _removeImage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  List<String> ShowDialogMarkaList = [
    "Apple",
    "Xiaomi",
    "Samsung",
    "Huawei",
    "Oppo",
    "Vivo",
    "Sony",
    "LG",
    "Nokia",
    "Lenovo",
    "Asus",
    "Casper",
    "Vestel",
    "Sony",
  ];
  List<String> ShowDialogModeColorlList = [
    "Mavi",
    "Turuncu",
    "Siyah",
    "Beyaz",
    "Bej",
    "Bronz",
    "Altın",
    "Gri",
    "Yeşil",
    "Bordo",
    "Lacivert",
    "Kırmzı",
    "Sarı",
    "Mor",
    "Pambe",
    "Kahverengi",
    "Diğer"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context).translate("EklePage.EklePageTitle")),
        iconTheme: IconThemeData(
          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black, // Replace with your color
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(AppLocalizations.of(context).translate("EklePage.Add_Image"),style: TextStyle(fontSize: 18),),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () async {
                            await _addImage(context, ImageSource.camera);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4.4,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Icon(CupertinoIcons.camera, size: 30, color: Colors.grey[400]),
                            ),
                          ),
                        );
                      } else if (_imagePaths[index - 1] == null) {
                        return GestureDetector(
                          onTap: () async {
                            await _addImage(context, ImageSource.gallery);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 4.4,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Icon(CupertinoIcons.add_circled, size: 30, color: Colors.grey[400]),
                            ),
                          ),
                        );
                      }

                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    insetPadding: EdgeInsets.all(10),

                                    content: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                        color: Colors.black,
                                        child: Center(
                                          child: Image.file(
                                            File(_imagePaths[index - 1]!),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 4.4,
                              height: 150,
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Image.file(
                                File(_imagePaths[index - 1]!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: GestureDetector(
                              onTap: () => _removeImage(index - 1),
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Icon(Icons.close, size: 19, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: _imagePaths.length + 1,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(AppLocalizations.of(context).translate("EklePage.brand"),style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black26),),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            String? text = await _showTextPickerDialog(context,ShowDialogMarkaList,AppLocalizations.of(context).translate("EklePage.Determine_the_Brand_of_the_Device_Show_Dialog"));
                            if (text != null) {
                              setState(() {
                                selectedText = text;
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar

                            decoration: BoxDecoration(
                              border: Border(

                                bottom: BorderSide(color: Colors.grey, width: 1.0), // Sadece altta bir çizgi oluşturduk
                              ),
                            ),
                            child: Text(
                              selectedText ?? AppLocalizations.of(context).translate("EklePage.What_is_a_Brand"),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 10,),
            //Cihaz Models
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar
                          child: TextField(
                            controller: _controllerModel,
                            maxLength: 40,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).translate("EklePage.Type_Your_Device_Model"),
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Renk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(AppLocalizations.of(context).translate("EklePage.Colour"),style: TextStyle(color:  Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black26),),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            String? text = await _showTextPickerDialog(context,ShowDialogModeColorlList,AppLocalizations.of(context).translate("EklePage.What_is_the_Color_of_the_Device"));
                            if (text != null) {
                              setState(() {
                                selectedTextRenk = text;
                              });
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar

                            decoration: BoxDecoration(
                              border: Border(

                                bottom: BorderSide(color: Colors.grey, width: 1.0), // Sadece altta bir çizgi oluşturduk
                              ),
                            ),
                            child: Text(
                              selectedTextRenk ?? AppLocalizations.of(context).translate("EklePage.What_is_Color"),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            //İlan Başlığı
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar
                          child: TextField(
                            controller: _controllerIlan,
                            maxLength: 70,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).translate("EklePage.Advert_title"),

                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Acıklama
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.1, // Bu sayede tüm genişliği kaplar
                          child: TextField(
                            controller: _controllerInfo,
                            maxLength: 240,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context).translate("EklePage.Explain_What_You_Sell"),

                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],

        ),

      ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(15),
          height: 100,

          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ]
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){},//Alıcıya sor buttonu sms ekranına yönlendir.
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.09,

                      padding: EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).translate("EklePage.Publish"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
    );
  }
  Future<String?> _showTextPickerDialog(BuildContext context,List itemList,String title) async {
    return showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade200,  // color özelliği artık BoxDecoration içerisine taşındı
                borderRadius: BorderRadius.circular(10.0),  // tüm köşelere 10.0 piksel yarıçapında yuvarlama
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(title,style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.normal),),
                  ),
                ],
              ),
            ),
            // Liste elemanları
            Expanded(
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(itemList[index]),
                    onTap: () {
                      Navigator.of(context).pop(itemList[index]);
                    },
                  );
                },
              ),
            ),
            // İptal düğmesi
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                    child: Text(AppLocalizations.of(context).translate("EklePage.CANCEL"),style: TextStyle(color: Colors.redAccent,fontSize: 18),),
                    onPressed: () {
                      Navigator.of(context).pop();  // Hiçbir şey döndürmez
                    },
                  ),
                ),
              ],
            ),


          ],
        );
      },
    );
  }
}
