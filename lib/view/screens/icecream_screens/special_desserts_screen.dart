import 'package:flutter/material.dart';
import 'package:graduation_project/controller/providers/providers.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../helper/helpers.dart';
import '../screens.dart';

class SpecialDessertsScreen extends StatefulWidget {
  const SpecialDessertsScreen({super.key});
  static const routeName = '/special_desserts_screen';

  @override
  State<SpecialDessertsScreen> createState() => _SpecialDessertsScreenState();
}

class _SpecialDessertsScreenState extends State<SpecialDessertsScreen> {
  int selectIndex = 1;
  @override
  Widget build(BuildContext context) {
    final specialDessertList =
        Provider.of<OtherStuffProvider>(context, listen: false)
            .specialDessertList;
    final thisrecentlyAddedList =
        Provider.of<OtherStuffProvider>(context, listen: false)
            .recentlyAddedList;
    final mostPopularList =
        Provider.of<OtherStuffProvider>(context, listen: false).mostPopularList;
    return RefreshIndicator(
      color: Colors.pink,
      onRefresh: () async {
        Provider.of<OtherStuffProvider>(context, listen: false).resetLists();
        final IceCreamProvider getIceCreamVar = IceCreamProvider();
        await getIceCreamVar.getIceCreams(context: context);
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SpecialAppBarHelper(
                    anotherFlag: false,
                    name: AppLocalizations.of(context)!.special_screen_header,
                    flag: true,
                    val: 25,
                  ),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var thisItem = specialDessertList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => IceCreamDetails(
                                  iceCream: specialDessertList[index],
                                ),
                              ),
                            );
                          },
                          child: BigContainer(
                            iceCream: thisItem,
                          ),
                        );
                      },
                      itemCount: specialDessertList.length,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectIndex = 1;
                              });
                            },
                            child: Text(
                              AppLocalizations.of(context)!.recently_added,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: selectIndex == 1
                                    ? const Color.fromRGBO(255, 100, 150, 1)
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectIndex = 2;
                              });
                            },
                            child: Text(
                              AppLocalizations.of(context)!.most_popular_tab,
                              style: TextStyle(
                                fontSize: 18,
                                color: selectIndex == 2
                                    ? const Color.fromRGBO(255, 100, 150, 1)
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  selectIndex == 1
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: SizedBox(
                            height: 500,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                var thisItem = thisrecentlyAddedList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => IceCreamDetails(
                                          iceCream:
                                              thisrecentlyAddedList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: SmallContainer(
                                    icecream: thisItem,
                                  ),
                                );
                              },
                              itemCount: thisrecentlyAddedList.length,
                            ),
                          ),
                        )
                      : Container(),
                  selectIndex == 2
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: SizedBox(
                            height: 500,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                var thisItem = mostPopularList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => IceCreamDetails(
                                          iceCream: mostPopularList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: SmallContainer(
                                    icecream: thisItem,
                                  ),
                                );
                              },
                              itemCount: mostPopularList.length,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
