import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/Register_page.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/show_snack_bar.dart';
import 'package:scholar_chat/pages/widgets/custom_button.dart';
import 'package:scholar_chat/pages/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
   LoginPage({Key? key}) : super(key: key);
   static String id = 'Login page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool isLoading = false ;

  GlobalKey<FormState> Formkey =GlobalKey();
  String? email , password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall :isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key :Formkey,
            child: ListView(
              children: [
                SizedBox(height: 75,),
                
                Image.asset('assets/images/scholar.png',
                 height : 100,
                ),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Scholar chat',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'Pacifico',
                    ),
                    
                    ),
                  ],
                ),
                 SizedBox(height: 75,),
                
              
                Row(
                  children: [
                    Text(
                      'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      
                    ),
                    
                    ),
                  ],
                ),
               
                 const SizedBox(height: 20,),
                CustomFormTextField(
                  onChanged: (data){
                    email = data;
                  },
                  hintText: 'Email',
                ),
               SizedBox(height: 10,),
                CustomFormTextField(
                  obscureText: true,
                  onChanged: (data){
                    password = data;
                  },
                  hintText: 'password',
                ),
               SizedBox(height: 20,),
                CustomButton(
                   onTap: () async {
                   if (Formkey.currentState!.validate()) {
                    isLoading = true;
                    setState ((){
                    });  
      try{
      await  loginUser();
      Navigator.pushNamed(context, chatPage.id);
            
      } on FirebaseAuthException catch(e){
                    if (e.code == 'user-not-found') {
       showSnackBar(context , 'user not found');
      } else if (e.code == 'wrong-password') {
       showSnackBar(context, 'wrong password');
         }
      }catch(e){
       showSnackBar(context, 'there was an error');
      }
            isLoading = false;
            setState(() {
              
            });
               }
              else{
                }
                  },
                   
      
                  text: 'LOGIN',
                ),
               SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont\'have an accout ?',
                  
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                       Navigator.pushNamed(context, RegisterPage.id,arguments: email);
                      },
                      child: Text('  Register',style: TextStyle(
                        color: Color (0xffC7EDE6),
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
     
  }
   Future<void> loginUser() async {
    UserCredential user =await FirebaseAuth.instance.signInWithEmailAndPassword(
     email: email!, password: password!);
  }
}

 
