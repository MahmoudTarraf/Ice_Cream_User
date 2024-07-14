// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/providers/providers.dart';
import '../../../model/models.dart';
import '../../helper/helpers.dart';
import '../screens.dart';

// ignore: must_be_immutable
class IceCreamHomePage extends StatefulWidget {
  const IceCreamHomePage({super.key});

  @override
  State<IceCreamHomePage> createState() => _IceCreamHomePageState();
}

class _IceCreamHomePageState extends State<IceCreamHomePage> {
  @override
  void initState() {
    _getUserInfo();
    _getOrders();

    super.initState();
  }

  Future<void> _getOrders() async {
    await Provider.of<OrderProvider>(context, listen: false)
        .getOrderByEmail(context);
  }

  Future<void> _getUserInfo() async {
    await Provider.of<UserProvider>(context, listen: false).getUserDetails();
  }

  final IceCreamProvider _iceCreamPovider = IceCreamProvider();
  final SpecialOffersProvider _offersProvider = SpecialOffersProvider();
  Color lightColor = const Color.fromARGB(255, 253, 222, 231);

  Color darkColor = const Color.fromARGB(255, 219, 120, 148);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _textSearch = '';

  void setTextSearch(String val) {
    _textSearch = val;
  }

  Future<void> validateThis() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final List<IceCream> theseIceCreams = Provider.of<OtherStuffProvider>(
      context,
      listen: false,
    ).searchIceCream(_textSearch);
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.searvh_is_made,
          style: const TextStyle(
            color: Colors.pink,
          ),
        ),
        content: Text(AppLocalizations.of(context)!.go_to_icecream),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              AppLocalizations.of(context)!.cancel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              AppLocalizations.of(context)!.go,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
    );
    if (isConfirmed != false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultScreen(
            iceCream: theseIceCreams,
            title: _textSearch,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localProvider = Provider.of<LocaleProvider>(context).currentLocale;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppBarHelper(),
                SearchFieldHelper(
                  searchHandler: setTextSearch,
                  validteThis: validateThis,
                ),
                // IconCreator(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    textDirection: localProvider == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    AppLocalizations.of(context)!.special_offers,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.pink,
                    ),
                  ),
                ),
                Provider.of<OtherStuffProvider>(context, listen: false)
                        .getOffersCondition
                    ? FutureBuilder(
                        future: _offersProvider.getAllOffers(context: context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final offers = Provider.of<OtherStuffProvider>(
                                    context,
                                    listen: false)
                                .theseOffers;

                            return SpecialOfferHelper(offers: offers);
                          } else {
                            return const Text('');
                          }
                        },
                      )
                    : SpecialOfferHelper(
                        offers: Provider.of<OtherStuffProvider>(context,
                                listen: false)
                            .theseOffers),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    textDirection: localProvider == const Locale('en')
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    AppLocalizations.of(context)!.popilar_categories,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.pink,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Provider.of<OtherStuffProvider>(context, listen: false)
                        .getIceCreamsCondition
                    ? FutureBuilder(
                        future: _iceCreamPovider.getIceCreams(context: context),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CategoryCreatorScreen(
                              categoryList: Provider.of<OtherStuffProvider>(
                                      context,
                                      listen: false)
                                  .uniqueList,
                            );
                          } else {
                            return const Text('');
                          }
                        },
                      )
                    : CategoryCreatorScreen(
                        categoryList: Provider.of<OtherStuffProvider>(context,
                                listen: false)
                            .uniqueList,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
