import 'package:flutter/material.dart';

class splashScreen extends StatelessWidget{
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
                height: 300,
                width: MediaQuery.of(context).size.width,
                "assets/meme2.jpg"),  // Adding a key ensures it updates the image properly

            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Let's Start" ,  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            )


          ],
        ),
      );
  }


}