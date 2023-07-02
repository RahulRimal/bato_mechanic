import 'package:bato_mechanic/screens/parts_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Vehicle> _vehicles = [
      Vehicle(
        name: 'Bike',
        image: 'images/vehicle/bike.png',
        type: '2 wheeler',
        tagLine: 'Two wheeler',
      ),
      Vehicle(
        name: 'Car',
        image: 'images/vehicle/car.png',
        type: '4 wheeler',
        tagLine: 'Small four wheeler',
      ),
      Vehicle(
        name: 'Bus',
        image: 'images/vehicle/bus.png',
        type: '4 wheeler',
        tagLine: 'Four wheeler',
      ),
      Vehicle(
        name: 'Semi',
        image: 'images/vehicle/semi.png',
        type: '4 wheeler',
        tagLine: 'Heavy Four wheeler',
      ),
      Vehicle(
        name: 'Machinary',
        image: 'images/vehicle/jcb.png',
        type: '4 wheeler',
        tagLine: 'Heavy four wheeler',
      ),
    ];

    return Scaffold(
      // backgroundColor: Colors.amber[800],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        // backgroundColor: Colors.amberAccent[200],
                        backgroundColor: Colors.amberAccent,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS111111111&usqp=CAU'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Rahul',
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notification_add),
                  ),
                ],
              ),
            ),
            Text(
              'Select your vehicle',
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
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PartsScreen())),
                child: Container(
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
