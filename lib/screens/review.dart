import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mymeds_app/components/common_buttons.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final user = FirebaseAuth.instance.currentUser;

  double rating = 1;
  final _messageController = TextEditingController();

  void _submitData() async {
    final message = _messageController.text;

    log('Rating: $rating, Message: $message');

    if (message.isNotEmpty) {
      await FirebaseFirestore.instance.collection('ratings').add({
        'rating': rating,
        'message': message,
        'timestamp': Timestamp.now(),
        'user': user!.uid,
        'email': user!.email,
      });

      // _ratingController.clear();
      setState(() {
        rating = 0;
      });
      _messageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Rating submitted successfully!'),
        ),
      );

      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid rating (1-5) and a message.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave Review ',
          style:
              TextStyle(color: Color(0xFF075260), fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TextField(
              //   controller: _ratingController,
              //   decoration: const InputDecoration(labelText: 'Rating (1-5)'),
              //   keyboardType: TextInputType.number,
              // ),
              const SizedBox(
                height: 100,
              ),

              Text('Rating: $rating', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              RatingBar.builder(
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (value) {
                  print(value);
                  setState(() {
                    rating = value;
                  });
                },
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  hintText: 'Write your review here',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(16.0),
                  // constraints: BoxConstraints(minHeight: 200),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                minLines: 1,
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              const SizedBox(height: 20),
              CommonButtons(
                textLabel: 'Submit',
                textColor: Colors.white,
                backgroundColor: Colors.green,
                onTap: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
