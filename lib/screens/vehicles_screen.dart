import 'package:bato_mechanic/screens/parts_screen.dart';
import 'package:flutter/material.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Vehicle> vehicles = [
      Vehicle(
        name: 'Bike',
        image: 'assets/images/vehicle/bike.png',
        type: '2 wheeler',
        tagLine: 'Two wheeler',
      ),
      Vehicle(
        name: 'Car',
        image: 'assets/images/vehicle/car.png',
        type: '4 wheeler',
        tagLine: 'Small four wheeler',
      ),
      Vehicle(
        name: 'Bus',
        image: 'assets/images/vehicle/bus.png',
        type: '4 wheeler',
        tagLine: 'Four wheeler',
      ),
      Vehicle(
        name: 'Semi',
        image: 'assets/images/vehicle/semi.png',
        type: '4 wheeler',
        tagLine: 'Heavy Four wheeler',
      ),
      Vehicle(
        name: 'Machinary',
        image: 'assets/images/vehicle/jcb.png',
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
            const SizedBox(
              height: 200,
            ),
            const Text(
              'Select your vehicle to repair',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: vehicles.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PartsScreen())),
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
                        // Image.asset('images/car.png'),
                        Image.asset(
                          vehicles[index].image,
                          width: 100,
                        ),
                        Text(
                          vehicles[index].name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          // 'Small four wheeler',
                          vehicles[index].tagLine,
                          style: const TextStyle(
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
