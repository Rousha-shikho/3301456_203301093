
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/pages/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chatPage extends StatelessWidget {

  static String id = 'chatPage';
  final _Controller = ScrollController();
  
   CollectionReference messages = FirebaseFirestore.instance.collection(KeyMessageCollections);
   TextEditingController Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KCreatedAt,descending: true).snapshots(),
      builder: (context , snapshot){
     
        if(snapshot.hasData){
          List<Message> messagesList=[];
          for(int i = 0; i<snapshot.data!.docs.length; i++)
          {
            messagesList.add(Message.fromJson(snapshot.data!.docs [i]));
          }
          return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(KLogo , 
            height: 50
            ),
            Text('Chat'),

          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _Controller,
              itemCount: messagesList.length,
              itemBuilder: (context, index) {
              return messagesList [index].id == email? chatBuble(message: messagesList [index]
              ,) : chatBubleForFriend(message: messagesList [index]);
            } ),
          ),
         Padding(
           padding: const EdgeInsets.all(16),
           child: TextField(
            controller: Controller ,
            onSubmitted: (data)
            {
              messages.add(
                {KMessage :data,KCreatedAt : DateTime.now(), 'id' : email }
                );
              Controller.clear();
              _Controller.animateTo(
               0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
              );
            },
            decoration: InputDecoration(
              hintText: 'Send Massage',
              suffixIcon: Icon(Icons.send,color: kPrimaryColor,),
            
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: kPrimaryColor,),
              ),
              
            ),
           ),
         ),
        ],
      ),
     );
        }else{
          return Text('Login....');
        }
      },
    );
  }
}
