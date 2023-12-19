import 'package:bedesten/AppLocalizations/AppLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnePageView extends StatefulWidget {
  final AnimationController animationController;

  const OnePageView({Key? key, required this.animationController}) : super(key: key);

  @override
  State<OnePageView> createState() => _OnePageViewState();
}

class _OnePageViewState extends State<OnePageView> {
  @override
  Widget build(BuildContext context) {
    final _introductionanimation = Tween<Offset>(begin: Offset(0,0),end: Offset(0.0,-1.0)).animate(CurvedAnimation(parent: widget.animationController, curve: Interval(0.0,0.2,curve: Curves.fastOutSlowIn)));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SlideTransition(
        position: _introductionanimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
                SizedBox(width: MediaQuery.of(context).size.width,
                child:Image.asset("images/welcome/wecome_image_one.png",
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Text("Bedesten",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: EdgeInsets.only(left: 64, right: 64),
                child: Text(
                  AppLocalizations.of(context).translate("HelloScren.HelloTextOnePage"),
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 16),
                child: InkWell(
                  onTap: () {
                    widget.animationController.animateTo(0.2);
                  },
                  child: Container(
                    height: 58,
                    padding: EdgeInsets.only(
                      left: 56.0,
                      right: 56.0,
                      top: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.0),
                      color: Color(0xff132137),
                    ),
                    child: Text(
                      AppLocalizations.of(context).translate("HelloScren.Comfort_Market"),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
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
