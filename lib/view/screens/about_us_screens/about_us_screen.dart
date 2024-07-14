import 'package:flutter/material.dart';
import 'package:graduation_project/view/helper/helpers.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  static const routeName = '/aboutus';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SpecialAppBarHelper(
                anotherFlag: false,
                name: "About Us",
                flag: false,
                val: 25,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Card(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        rowBuilder('Version :', "^1.0.0"),
                        questionAnswer(
                          'Who Are We?',
                          'Icy Delights is an application made with flutter as a frontend and Django as a backend,This is a Special application for searching an IceCream and making a purchase using Syriatel Cash App\n (أقرب إليك), This application was made using Provider state managment solution!',
                        ),
                        questionAnswer(
                          'Required Information?',
                          'You will be required to enter your UserName,Email,Location,Password if you are signing up for the first time, or you can enter your username,password if you have already created an account and want to login!',
                        ),
                        questionAnswer(
                          'Search For IceCream?',
                          'Simply select the desired icecream, Either by going to your favorite category then adding icecreams to the cart, Or by searching your desired icecream then adding it to the cart!',
                        ),
                        questionAnswer('How to Purchase?',
                            'After you have selected your favorite icecreams, then you can go to checkout and make a transfer to 0939672432 .\n Then enter the operation number you recieved in the text field to place your order!'),
                        questionAnswer('My orders?',
                            'Every order you made will show in Your Orders page in the Finished tab, However your order may not have started yet, Or it is pending,Then you can find these orders in the Unfinised tab!'),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget rowBuilder(
  String name,
  String value,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    ),
  );
}

Widget questionAnswer(String question, String answer) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 10,
        ),
        child: Center(
          child: Text(
            question,
            style: const TextStyle(
              color: Colors.pink,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            answer,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    ],
  );
}
