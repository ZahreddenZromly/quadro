import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quadro/components/category_tile.dart';
import 'package:quadro/components/search_bar.dart';
import 'package:quadro/components/workshop_card.dart';
import 'package:quadro/screens/categories_screen.dart';
import 'package:quadro/screens/profile_screen.dart';

import '../workshop_user/car_status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>   CarStatus(),
                  ),
                );
              },
              icon: const Icon(
                Icons.notifications_active,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [


          const SizedBox(height: 8),
          Container(
            height: 180, // Adjust the height according to your need
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.teal[600],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/workshops/welcome.jpg', // Replace 'your_image.png' with your image path
                 fit:BoxFit.cover,
                width: double.infinity, // Set the image width to the container width
                height: double.infinity,// Adjust the width of the image
              ),
            ),
          ),
          const SizedBox(height: 8),
          const QSearchBar(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Workshops: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                // Your other Slivers here
                SliverPadding(
                  padding: EdgeInsets.only(top: 8.0),
                  sliver: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('workshops')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child:
                              Center(child: Text('Error: ${snapshot.error}')),
                        );
                      }
                      final workshops = snapshot.data!.docs;
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final workshop = workshops[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: WorkshopCard(
                                workshopName: workshop['workshopName'],
                                contactInfo: workshop['contactInfo'],
                              ),
                            );
                          },
                          childCount: workshops.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.72,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
