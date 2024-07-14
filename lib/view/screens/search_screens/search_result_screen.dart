import 'package:flutter/material.dart';

import 'package:graduation_project/view/screens/screens.dart';

import '../../../model/models.dart';
import '../../helper/helpers.dart';

class SearchResultScreen extends StatefulWidget {
  final String title;
  final List<IceCream> iceCream;
  const SearchResultScreen({
    super.key,
    required this.iceCream,
    required this.title,
  });
  static const routeName = '/search_results_screen';

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: widget.iceCream.isEmpty
            ? Column(
                children: [
                  SpecialAppBarHelper(
                    anotherFlag: false,
                    name: 'Search Results For "${widget.title}"',
                    flag: true,
                    val: 20.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 200,
                    ),
                    child: Center(
                      child: Text(
                        'Search Is Empty',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SpecialAppBarHelper(
                        anotherFlag: false,
                        name: 'Search Results For "${widget.title}"',
                        flag: true,
                        val: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: SizedBox(
                          height: 700,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              var thisItem = widget.iceCream[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => IceCreamDetails(
                                        iceCream: widget.iceCream[index],
                                      ),
                                    ),
                                  );
                                },
                                child: SearchHelper(
                                  icecream: thisItem,
                                ),
                              );
                            },
                            itemCount: widget.iceCream.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
