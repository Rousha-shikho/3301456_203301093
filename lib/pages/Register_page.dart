import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/show_snack_bar.dart';
import 'package:scholar_chat/pages/widgets/custom_button.dart';
import 'package:scholar_chat/pages/widgets/custom_text_field.dart';


class RegisterPage extends StatefulWidget {
   RegisterPage({Key? key}) : super(key: key);
  static String id = 'RegisterPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false ;

  GlobalKey<FormState> Formkey =GlobalKey();

  @override
  Widget build(BuildContext context) {
    
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: Formkey,
            child: ListView(
              children: [
               SizedBox(height: 75,),
                Image.asset('assets/images/scholar.png',
                height: 100,
                
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
                      'REGISTER',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                     ),
                    ),
                  ],
                ),
               
                 const SizedBox(height: 20,),
                CustomFormTextField(
                  onChanged: (data)
                  {
                    email = data;
                  },
                  hintText: 'Email',
                ),
               SizedBox(height: 10,),
                CustomFormTextField(
                  onChanged: (data)
                  {
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
      await registerUser();

      Navigator.pushNamed(context, chatPage.id);
            
      } on FirebaseAuthException catch(e){
                    if (e.code == 'weak-password') {
       showSnackBar(context , 'weak password');
      } else if (e.code == 'email-already-in-use') {
       showSnackBar(context, 'email already exists');
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
                   
                  text: 'REGISTER',
                ),
               SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an accout ?',
                  
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    
                    ),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator .pop(context);
                      },
                      child: Text(
                        '  LOGIN',
                      style: TextStyle(
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

  Future<void> registerUser() async {
    UserCredential user =await FirebaseAuth.instance.createUserWithEmailAndPassword(
     email: email!, password: password!);
  }
}