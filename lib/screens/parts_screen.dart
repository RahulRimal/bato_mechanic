import 'package:flutter/material.dart';

import 'track_mechanic_screen.dart';

class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PartsCategory> categories = [
      PartsCategory(
        name: 'Wheels',
        image: 'assets/images/parts/wheel.png',
      ),
      PartsCategory(
        name: 'Engine',
        image: 'assets/images/parts/engine.png',
      ),
      PartsCategory(
        name: 'Electricity',
        image: 'assets/images/parts/electricity.png',
      ),
      PartsCategory(
        name: 'Body',
        image: 'assets/images/parts/body.png',
      ),
      PartsCategory(
        name: 'Accessories',
        image: 'assets/images/parts/accessories.png',
      ),
    ];
    return Scaffold(
      // backgroundColor: Colors.amber[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Where is the problem being occured?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TrackMechanicScreen(
                      mechanicName: 'John Doe',
                      estimatedTimeOfArrival: '10 minutes',
                      mechanicLocation: '123 Main Street',
                    ),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
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
                        categories[index].image,
                        width: 100,
                      ),
                      Text(
                        categories[index].name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
