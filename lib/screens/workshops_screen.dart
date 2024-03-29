import 'package:flutter/material.dart';
import 'package:quadro/components/search_bar.dart';
import 'package:quadro/components/workshop_list_tile.dart';

class WorkshopsScreen extends StatelessWidget {
  const WorkshopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.grey[100],
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, size: 25),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 32),
          child: Text(
            'Workshops',
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
            ),
          ),
        ),
        // Other AppBar properties...
      ),
      body: const Column(
        children: [
          QSearchBar(),
          // Text('hello'),
          SizedBox(height: 32),
          WorkshopListTile(),
        ],
      ),
    );
  }
}
