import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/components/my_textfield.dart';

import '../components/my_button.dart';
import '../database/firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FirestoreDb database = FirestoreDb();
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController newPostController = TextEditingController();

  //sign user out method
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  void postButton(){
    if(newPostController.text.isNotEmpty){
      String message = newPostController.text;
      database.addPost(message);
    }

    newPostController.clear();
  }

  Future<void> _deletePost(String postId) async {
    try {
      await database.deletePost(postId);
    } catch (e) {
      print('Error deleting post: $e');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: Row(
          children: [
           const Spacer(),
            const Icon(Icons.person),
            const SizedBox(width: 8),
            Text(
                 user.email ?? '',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        actions: [IconButton(
          onPressed: signUserOut,
          icon: const Icon(Icons.logout),
      ),
      ],
      ),

      body: Column(
        children: [
          const SizedBox(height: 50,),
          Container(
            alignment: Alignment.center,
            child: const Text(
              "Welcome to this page!",
              style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent
              ),
            ),
          ),
          const SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [

                 const SizedBox(height: 50,),

                Expanded(
                  child: MyTextField(
                      controller: newPostController,
                      hintText: "What's on your mind?",
                      obscureText: false
                  ),
                ),
                PostButton(onTap: postButton)
              ],
            ),
          ),

          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final posts = snapshot.data!.docs;

                if(snapshot.data == null || posts.isEmpty){
                  return const Center(child: Padding(padding: EdgeInsets.all(25),
                    child: Text("No posts...Post something!"),
                  ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      String message = post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];
                      String postId = post.id; // Add this line to get the document ID

                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: ListTile(
                          title: Text(message),
                          subtitle: Text(
                            userEmail,
                            style: const TextStyle(color: Colors.pink),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletePost(postId);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
          )
        ],
      ),
    );
  }
}
