import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:hello_flutter/colors.dart";

class Switzerland extends StatefulWidget {
  const Switzerland({Key? key}) : super(key: key);

  @override
  State<Switzerland> createState() => _SwitzerlandState();
}

class _SwitzerlandState extends State<Switzerland> {
  @override
  String description = "Oeschinen Lake is a lake in the Bernese Oberland, Switzerland, 4 kilometres east of Kandersteg in the Oeschinen valley. At an elevation of 1,578 metres, it has a surface area of 1.1147 square kilometres. Its maximum depth is 56 metres.The lake was created by a giant landslide and is fed through a series of mountain creeks and drains underground.";

  String description2 = "It might be most famous for its incredible Alps but Switzerland also has its fair share of beautiful lakes. Lake Oeschinen, located in the Bernese Oberland near Kandersteg, is considered one of the most stunning lakes in all of Switzerland.  And rightly so. Framed by the peaks of Bluemlisalp and Doldernhorn, Lake Oeschinen (Oeschinensee in German) is filled with exceptionally clear turquoise water.";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello Flutter!"),
        backgroundColor: pink,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Hello scaffold"),
              icon: const Icon(
                Icons.mail,
                color: Colors.white54,
              )),
          IconButton(
              onPressed: () => debugPrint("Hello scaffold sms"),
              icon: const Icon(Icons.sms))
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/switzerland.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Oeschinen Lake Campground",
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Kandersteg, Switzerland",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.red,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "41",
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(
                    FontAwesomeIcons.phone,
                    size: 25,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "CALL",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Column(
                children: const [
                  Icon(
                    FontAwesomeIcons.locationArrow,
                    size: 25,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "ROUTE",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Column(
                children: const [
                  Icon(
                    FontAwesomeIcons.shareNodes,
                    size: 25,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "SHARE",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w400),
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(description, style: const TextStyle(height: 1.3, color: Colors.black87),),
          )
        ],
      ),
    );
  }
}
