import 'dart:ffi';

import 'package:exp/User.dart';
import 'package:flutter/material.dart';
import 'package:moneytextformfield/moneytextformfield.dart';


import 'User.dart';
import 'Profile.dart';


class ProfileTab extends StatefulWidget {
  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPassController = TextEditingController();
  final limitController = TextEditingController();
  static Profile profile = Profile();


  
  @override
  Widget build(BuildContext context) {
    final usernameField = TextField(
      controller: usernameController,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: 'Enter Username',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),      
    );

    final emailField = TextField(
      controller: emailController,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: 'Enter Email',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),      
    );

    final passwordField = TextField(
      controller: passwordController,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: 'Enter Password',
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),      
    );

    final passwordField2 = TextField(
      controller: confirmedPassController,
      decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      hintText: 'Re-enter Password',
      //confirm password???
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),      
    );

    // final monthlyLimit  = TextFormField(
    //   controller: limitController,
    // );

    final monthlyLimit = MoneyTextFormField(
              settings: MoneyTextFormFieldSettings(
                validator: (value) {
                  if (value.isEmpty || double.parse(value) <= 0.0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
                controller: limitController,
              ),
            );
    var user = User();

    // Widget _skipButton(){
    //   return  Hero(
    //   tag: 'hero',
    //   child: Padding(
    //   padding: EdgeInsets.symmetric(vertical: 20.0),
    //   child: RaisedButton(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     onPressed: () {
    //     },
    //     padding: EdgeInsets.all(12),
    //     color: Colors.lightBlueAccent,
    //     child: Text('Skip', style: TextStyle(color: Colors.white))
    //   )
    //   )
    //   );
    // }

    //  Widget _nextButton(){
    //   return  Hero(
    //   tag: 'hero',
    //   child: Padding(
    //   padding: EdgeInsets.symmetric(vertical: 20.0),
    //   child: RaisedButton(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     onPressed: () {
    //       // if (value.isEmpty || double.parse(value) <= 0.0) {
    //       //           return 'Please enter a valid amount';
    //       //         }
    //     },
    //     padding: EdgeInsets.all(12),
    //     color: Colors.lightBlueAccent,
    //     child: Text('Next', style: TextStyle(color: Colors.white))
    //   )
    //   )
    //   );
    // }
    
    

    Widget _optionalLimit(){
      // ask for monthly limit
      // have option for skip and next
      // if no num, give error msg
      return Scaffold(
        body: 
        Container(
                  padding: EdgeInsets.only(top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                        "What is your monthly limit? (Optional)",
                        textAlign: TextAlign.left,
                      ),
                      
                      ),
                      //InputField Widget from the widgets folder
                      // InputField(
                      //   label: "Name",
                      //   content: "Name"
                      // ),
                      //monthlyLimit,
                      monthlyLimit,
                      // SizedBox(height: 20.0),
                      // _skipButton(),
                      // SizedBox(width: 5),
                      // _nextButton(),
                      // SizedBox(height: 20.0),
                      // RaisedButton(
                      //   child: Text("Skip"),
                      //   onPressed: null,
                      // ),
                      // SizedBox(width: 5),
                      // RaisedButton(
                      //   child: Text("Next"),
                      //   onPressed: null,
                      // )
                  
                    ]
                  ),
                  
      ),
      // Center(
      //   Container(
      //   child:  Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: <Widget>[
      //                 RaisedButton(
      //                   child: Text("LogIn"),
      //                   onPressed: null,
      //                 ),
      //                 SizedBox(width: 5),
      //                 RaisedButton(
      //                   child: Text("SignUp"),
      //                   onPressed: null,
      //                 ),
      //               ],
      //             ),))
      );
    }
    void _monthlyLimit() {
      Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Monthly Limit'),
        ),
        body: _optionalLimit()
      );
    }));
    }

    final loginButton =  Hero(
      tag: 'hero',
      child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () {
          
          user.username = usernameController.text;
          user.email = emailController.text;
          user.password = passwordController.text;
          user.confirmedPassword = confirmedPassController.text;
          //    Navigator.of(context).pushNamed(HomePage.tag);
          if(profile.correctFields(user)!= 'valid'){
            return showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Text(profile.correctFields(user),
                  style: TextStyle(color: Colors.red)),
                );
              }
            );
          }
          
          setState(() {
              _monthlyLimit();
            });
        },
        padding: EdgeInsets.all(12),
        color: Colors.lightBlueAccent,
        child: Text('Confirm', style: TextStyle(color: Colors.white)),
      ),
    ),
    );

    

    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign Up'),
        
      ),
      body: Center(
        
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.person_pin_rounded, 
                      size: 90
                    ),
                    
                    SizedBox(
                      height: 100.0,
                      
                      // child: Image.asset(
                      //   "assets/logo.png",
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                    
                    usernameField,
                    SizedBox(height: 25.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 25.0),
                    passwordField2,
                    SizedBox(height: 25.0),
                    loginButton
                  ]),)));
    // return Container(
    //   //color: Colors.green,
    // );
  }

  


  // https://pusher.com/tutorials/login-ui-flutter
  // https://medium.com/@harshil.js/flutter-complete-log-in-sign-up-with-material-design-and-animation-8949b3eab6ea

  //Widget _getInfo(){
  // return TextField(
  //   decoration: InputDecoration(
  //     border: InputBorder.none,
  //     hintText: 'Enter name'
  //   )
  // );
//}

}


