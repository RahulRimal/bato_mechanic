import 'package:flutter/material.dart';

class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PartsCategory> _categories = [
      PartsCategory(
        name: 'Wheels',
        image: 'images/parts/wheel.png',
      ),
      PartsCategory(
        name: 'Engine',
        image: 'images/parts/engine.png',
      ),
      PartsCategory(
        name: 'Electricity',
        image: 'images/parts/electricity.png',
      ),
      PartsCategory(
        name: 'Body',
        image: 'images/parts/body.png',
      ),
      PartsCategory(
        name: 'Accessories',
        image: 'images/parts/accessories.png',
      ),
    ];
    return Scaffold(
      // backgroundColor: Colors.amber[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'Where is the problem being occured?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.amberAccent[200],
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        _categories[index].image,
                        width: 100,
                      ),
                      Text(
                        _categories[index].name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text(
                      //   // 'Small four wheeler',
                      //   _vehicles[index].tagLine,
                      //   style: TextStyle(
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // )
                    ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class Vehicle {
  Vehicle(
      {required this.name,
      required this.image,
      required this.type,
      required this.tagLine});

  String image;
  String name;
  String type;
  String tagLine;
}

class PartsCategory {
  PartsCategory({required this.name, required this.image});
  String name;
  String image;
}
