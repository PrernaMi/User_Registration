import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_registration/model/user_model.dart';
import 'package:user_registration/providers/connectivity_provider.dart';
import 'package:user_registration/providers/offline_data_provider.dart';
import 'package:user_registration/screens/pending_submission.dart';

class UserRegistration extends StatefulWidget {
  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  MediaQueryData?mqData;

  bool? isOnline;

  @override
  void initState() {
    //get isOnline or not through provider
    isOnline = context.watch<ConnectivityProvider>().getNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create Account",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("Get started by creating new account",
              style: TextStyle(color: Colors.grey.shade400),),
            SizedBox(height: 15,),
            /*---------Name---------*/
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Full Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 10,),
            /*---------Email---------*/
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 10,),
            /*---------Phone---------*/
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Mobile No",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 10,),
            /*---------Password---------*/
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
            SizedBox(height: 10,),
            /*---------Submitted Button---------*/
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(mqData!.size.width * 0.9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                onPressed: () {
                  handleSubmit();
                  //isOnline then save data in sqflite(After we will store in API)

                  //isOnline false then save data in provider

                },
                child: Text("Register",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),))
          ],
        ),
      ),
    );
  }
  void handleSubmit() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      // Save data locally
      context.read<OfflineDataProvider>().setOfflineData(UserModel(
          name: nameController.text.toString(),
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
          phone: phoneController.text.toString()));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return PendingSubmission();
      }));
    } else {
      // Submit data to server
      //directly save in sqflite
    }
  }
}