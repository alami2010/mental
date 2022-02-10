import 'package:flutter/material.dart';


import 'constants/constants.dart';

class MyHomePageX extends StatelessWidget {
  const MyHomePageX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Color(0xfff5f7fa),
          body: Column(children: [
            Stack(
              children: [

                GradientContainer(size),
                Container(
                    height: 200,
                    width: size.width,
                    child: Image.asset(ImageRasterPath.logo)
                ),
               ],
            ),
            DevicesGridDashboard(size: size),
          ]));
    });
  }

  Padding CustomCard(Size size, context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(

        child: Container(
          height: size.height * .15,
          width: size.width * .5,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/bg.jpg",
                ),
                fit: BoxFit.cover,
              )),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black.withOpacity(0.3),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 15, top: size.height * .12),
              child: const Text(
                'Room',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container GradientContainer(Size size) {
    return Container(
      height: size.height * .3,
      width: size.width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            gradient: LinearGradient(colors: [
              secondaryColor.withOpacity(0.9),
              primaryColor.withOpacity(0.9)
            ])),
      ),
    );
  }
}


class CardWidget extends StatelessWidget {
  Icon icon;
  String title;

  CardWidget({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: 50,
        width: 200,
        child: Center(
          child: ListTile(
            leading: icon,
            title: Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

class DevicesGridDashboard extends StatelessWidget {
  const DevicesGridDashboard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Text(
              "Devices",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.blue,
                  Icon(
                    Icons.camera_outlined,
                    color: Colors.white,
                  ),
                  'Cameras',
                  '8 Devices'),
              CardField(
                  size,
                  Colors.amber,
                  Icon(Icons.lightbulb_outline, color: Colors.white),
                  'Lights',
                  '8 Devices'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.orange,
                  Icon(Icons.music_note_outlined, color: Colors.white),
                  'Speakers',
                  '2 Devices'),
              CardField(
                  size,
                  Colors.teal,
                  Icon(Icons.sports_cricket_sharp, color: Colors.white),
                  'Cricket bat',
                  '8 Devices'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardField(
                  size,
                  Colors.purple,
                  Icon(Icons.wifi_outlined, color: Colors.white),
                  'Sensors',
                  '5 Devices'),
              CardField(
                  size,
                  Colors.green,
                  Icon(Icons.air_outlined, color: Colors.white),
                  'Air Condition',
                  '4 Devices'),
            ],
          )
        ],
      ),
    );
  }
}

CardField(
  Size size,
  Color color,
  Icon icon,
  String title,
  String subtitle,
) {
  return Padding(
    padding: const EdgeInsets.all(2),
    child: Card(
        child: SizedBox(
            height: size.height * .1,
            width: size.width * .39,
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color,
                  child: icon,
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                subtitle: Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ))),
  );
}
