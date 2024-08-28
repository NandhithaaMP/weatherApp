import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/loginScreen.dart';
import 'package:weatherapp/provider/mainProvider.dart';
import 'package:weatherapp/registrationScreen.dart';


class getstarted extends StatelessWidget {
  const getstarted({super.key});


  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<MainProvider>(
        builder: (context,value100,child) {
          return Container(
            height: height * 1,
            width: width * 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffAD52D0),
                  Color(0xff5A42B1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),

            ),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 225),
                //   child: Image.asset("assets/icon.webp",scale: 7,),
                // ),
                Text(
                  "Weather App",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 40,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 275),
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.65,
                    decoration: BoxDecoration(
                        color: Color(0xffE1DEDE),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: InkWell(
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        var user = prefs.getString("phone_number");

                        if(user != null){
                          value100.userAuthorized(user, context);
                        }
                        else {
    Navigator.push(context, MaterialPageRoute(
    builder: (context) => LoginScreen()));}},

                      child: Center(
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}