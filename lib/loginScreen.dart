import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/otpScreen.dart';
import 'package:weatherapp/provider/mainProvider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    // TextEditingController phoneController=TextEditingController();
    return Scaffold(
      backgroundColor: Color(0xff78ab83),
      body: Consumer<MainProvider>(
        builder: (context,value10,chikd) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login",style: TextStyle(color: Colors.purple)),
                // SizedBox(height:height/10 ,),
                // TextFormField(
                //   decoration: InputDecoration(
                //     label: Text("Name",style: TextStyle(color: Colors.blue),),
                //     prefixIcon: Icon(Icons.person),
                //     enabledBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15),
                //         borderSide: BorderSide(color: Colors.purple)
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(15),
                //       borderSide: BorderSide(color: Colors.purple)
                //     )
                //   ),
                //
                // ),
                SizedBox(height:height/20 ,),
                TextFormField(
                  controller: value10.phoneController,
                  keyboardType: TextInputType.phone,
                  // inputFormatters: <TextInputFormatter>[
                  //   // FilteringTextInputFormatter.digitsOnly,
                  //   LengthLimitingTextInputFormatter(14)
                  // ],
                  decoration: InputDecoration(
                    label: Text("Enter Phone Number",style: TextStyle(color: Colors.purple),),
                    prefixIcon: Icon(Icons.phone),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.purple)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.purple)
                    ),

                  ),

                ),
                SizedBox(height: height/20,),
                ElevatedButton(onPressed: ()async {

                  value10.sendOTP(context);

                }, child: Text("Verify Phone number")

                )
              ],
            ),
          );
        }
      ),
    );
  }
}
