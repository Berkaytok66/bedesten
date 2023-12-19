import 'package:bedesten/Companent/my_button.dart';
import 'package:bedesten/Screens/SingUpScreen.dart';
import 'package:bedesten/wigets/navbar_roots.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login_screen.dart';

class WelcomeScren extends StatelessWidget {

  void Login(BuildContext context){

  }
  @override
  Widget build(BuildContext context) {


    return Material(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => navbar_roots()));
                },
                child: Text("SKİP",
                  style: TextStyle(color: Color(0xFF7165D6),fontSize: 20),),
              ),
            ),
            SizedBox(height: 30,),
            Padding(padding: EdgeInsets.all(20),
              child: Image.asset("images/login_logo.png"),
            ),
            SizedBox(height: 40,),
            Text("Bedestene hoş geldiniz",style: TextStyle(color: Color(0xFF7165D6),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 2),),

            SizedBox(height: 40,),
            Text("Şehrinin Esnafları ile tanış"
              ,style: TextStyle(color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 150,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                      onTap: (){
                         Navigator.pushReplacement(
                             context,
                             MaterialPageRoute(builder: (context) => Login_screen(),
                             ));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                        child: Text("Sing In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      )
                  ),
                ),
                Material(
                  color: Color(0xFF7165D6),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: (){
                       Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(builder: (context) => SingUpScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                      child: Text("Sing Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),),
                    )
                  ),
                )
              ],
            ),


          ],
        ),

      ),
    );
  }
}
