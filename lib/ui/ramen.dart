import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_flutter/colors.dart';

class Ramen extends StatefulWidget {
  const Ramen({Key? key}) : super(key: key);

  @override
  State<Ramen> createState() => _RamenState();
}

class _RamenState extends State<Ramen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ramen"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ramen.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 25.0, bottom: 15.0),
            width: double.infinity,
            color: Colors.black,
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.solidCircle, size: 10, color: yellow),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.solidCircle, size: 10, color: yellow),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.solidCircle, size: 10, color: yellow),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.circleHalfStroke,
                    size: 10, color: yellow),
                SizedBox(width: 5),
                Icon(FontAwesomeIcons.circle, size: 10, color: yellow)
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              color: Colors.black,
              child: Column(
                children: [
                  const Text(
                    "Balsamic Basil Chicken",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text("\$12.30",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500)),
                      SizedBox(width: 20),
                      Text("Discount price",
                          style: TextStyle(color: Colors.white30, fontSize: 17))
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.",
                      style: TextStyle(color: Colors.white70, fontSize: 18)),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Calory",
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 16)),
                          SizedBox(height: 8),
                          Text("\$12.30",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Delivery Cost",
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 16)),
                          SizedBox(height: 8),
                          Text("Free",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("Delivery Time",
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 16)),
                          SizedBox(height: 8),
                          Text("02.00pm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white),
                        child: const Icon(
                          FontAwesomeIcons.bagShopping,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: yellow,
                            fixedSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(FontAwesomeIcons.chevronRight, color: Colors.black, size: 15),
                              SizedBox(width: 8),
                              Text('Checkout', style: TextStyle(color: Colors.black, fontSize: 18),),
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
