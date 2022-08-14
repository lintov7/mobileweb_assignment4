import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  // Function to check whether the user is logged in or not.
  // If the user is not logged in redirect to login page
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.of(context).pushReplacementNamed('/login');
    }
    return firebaseApp;
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut(); // Code to signs out a user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout Icon',
            onPressed: () async{
              await _signOut();
              Navigator.of(context).pushReplacementNamed("/login");
            },
          ), //Ico
        ],
      ),
      body: FutureBuilder( // Future builder to check the firebase status
          future: _initializeFirebase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/weather");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        child: Text('Weather', style: TextStyle(
                          fontSize: 18
                        )),
                      ),
                    ),
                    const SizedBox(height:20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/news");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        child: Text('News', style: TextStyle(
                            fontSize: 18
                        )),
                      ),
                    ),
                    const SizedBox(height:20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/calculator");
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        child: Text('Calculator', style: TextStyle(
                            fontSize: 18
                        )),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(), // Creates a circular progress view
              );
            }
          }),
    );
  }
}
