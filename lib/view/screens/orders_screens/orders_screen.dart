import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../controller/providers/providers.dart';
import '../screens.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const routeName = '/final_orders_screen';
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  // Create TabController instance
  late final TabController _tabController;
  Future<void> _getOrders() async {
    await Provider.of<OrderProvider>(context, listen: false)
        .getOrderByEmail(context);
  }

  @override
  void initState() {
    _getOrders();
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Initialize TabController
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose of TabController when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Match TabController length
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Center(
              child: Text(
                AppLocalizations.of(context)!.orders_screen,
              ),
            ), // Adjusted title
            bottom: TabBar(
              controller: _tabController, // Use TabController
              tabs: [
                Tab(
                    icon: const Icon(Icons.check_circle),
                    text: AppLocalizations.of(context)!.finished_tab),
                Tab(
                    icon: const Icon(Icons.access_time),
                    text: AppLocalizations.of(context)!.unfinished_tab),
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController, // Use TabController
            children: const [
              FinishedScreen(),
              UnFinishedScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
