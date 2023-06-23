import 'package:flutter/material.dart';

class PartsScreen extends StatelessWidget {
  const PartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Vehicle> _vehicles = [
      Vehicle(
        name: 'Bike',
        image: 'images/bike.png',
        type: '2 wheeler',
        tagLine: 'Two wheeler',
      ),
      Vehicle(
        name: 'Car',
        image: 'images/car.png',
        type: '4 wheeler',
        tagLine: 'Small four wheeler',
      ),
      Vehicle(
        name: 'Bus',
        image: 'images/car.png',
        type: '4 wheeler',
        tagLine: 'Four wheeler',
      ),
      Vehicle(
        name: 'Semi',
        image: 'images/semi.png',
        type: '4 wheeler',
        tagLine: 'Heavy Four wheeler',
      ),
      Vehicle(
        name: 'Machinary',
        image: 'images/jcb.png',
        type: '4 wheeler',
        tagLine: 'Heavy four wheeler',
      ),
      Vehicle(
        name: 'Car',
        image: 'images/car.png',
        type: 'car',
        tagLine: 'Small four wheeler',
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
              'Parts Screen',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _vehicles.length,
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
                      // Image.asset('images/car.png'),
                      Image.asset(
                        _vehicles[index].image,
                        width: 100,
                      ),
                      Text(
                        _vehicles[index].name,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // 'Small four wheeler',
                        _vehicles[index].tagLine,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
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
