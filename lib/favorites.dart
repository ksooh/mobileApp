import 'package:flutter/material.dart';

import 'style.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // Sample list of favorites
  List<String> favorites = ['Place 1', 'Place 2', 'Place 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '즐겨찾기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColor.blue1,
        automaticallyImplyLeading: false, // Hide the back button
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddItemDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _navigateToItemPage(context, favorites[index]);
            },
            child: Dismissible(
              key: Key(favorites[index]),
              onDismissed: (direction) {
                setState(() {
                  favorites.removeAt(index);
                });
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: ListTile(
                title: Text(favorites[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    TextEditingController newItemController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('즐겨찾기 추가'),
          content: TextField(
            controller: newItemController,
            decoration: InputDecoration(
              labelText: '이름',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  favorites.add(newItemController.text);
                });
                Navigator.pop(context); // Close the dialog
              },
              style: ElevatedButton.styleFrom(
                primary:
                    AppColor.blue1, // Set your desired background color here
              ),
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  // //ver1
  // void _navigateToItemPage(BuildContext context, String itemName) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ItemPage(itemName: itemName),
  //     ),
  //   );
  // }

  // ver2
  void _navigateToItemPage(BuildContext context, String itemName) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(itemName),
              ),
              SizedBox(height: 16.0),
              Center(
                child: Text('This is the content for $itemName'),
              ),
            ],
          ),
        );
      },
    );
  }

  // //ver3
  // void _navigateToItemPage(BuildContext context, String itemName) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(itemName),
  //         content: Center(
  //           child: Text('This is the page for $itemName'),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Close the dialog
  //             },
  //             child: Text('닫기'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}

class ItemPage extends StatelessWidget {
  final String itemName;

  const ItemPage({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Center(
        child: Text('This is the page for $itemName'),
      ),
    );
  }
}
