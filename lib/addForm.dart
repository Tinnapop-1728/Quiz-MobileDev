import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class addForm extends StatefulWidget {
  @override
  State<addForm> createState() => _addFormState();
}

class _addFormState extends State<addForm> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  CollectionReference reviewCollection = FirebaseFirestore.instance.collection(
    'Review',
  );

  double rating = 3.0 ;    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 34, 123, 1),
        title: Center(
          child: Text(
            '!!! Review Here !!!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color.fromARGB(255, 230, 239, 251),

      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [

                SizedBox(height: 20),

                TextFormField(
                  controller: titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Restaurant Name',
                    prefixIcon: Icon(Icons.house),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    filled: true ,
                    fillColor: Colors.white
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Start a Review',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30)),
                    filled: true ,
                    fillColor: Colors.white
                  ),
                  
                ),
                SizedBox(height: 20),
                
                Text('Rate this Restaurant', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),

                SizedBox(height:  15),

                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),

                SizedBox(height:  15),

                ElevatedButton(
                  onPressed: () {
                    reviewCollection.add({
                      'title': titleController.text,
                      'description': descriptionController.text,
                      'rating' : rating 
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Review'), 
                ),

                SizedBox(height: 15),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  }, 
                  child: Icon(Icons.arrow_back_ios_new))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
