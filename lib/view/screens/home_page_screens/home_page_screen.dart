import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:graduation_project/controller/Auth/config.dart';
// import 'package:graduation_project/controller/syriatel_cash/notification_service.dart';

// import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../screens.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebSocketChannel channel;

  @override
  void initState() {
    // Connect to WebSocket server
    // NotificationService().initNotification();
    // channel = IOWebSocketChannel.connect(Config.webSocketUrl);
    // channel.stream.listen((message) {
    //   NotificationService().showNotification(message);
    // }, onError: (error) {
    //   throw error;
    // });
    super.initState();
  }

  int _selectedIndex = 2;
  Widget getWidgets(int index) {
    switch (index) {
      case 0:
        return const Profile6();
      case 1:
        return const OrdersScreen();
      case 2:
        return const IceCreamHomePage();
      case 3:
        return IceCreamCart();
      // case 4:
      //   return const Center(child: Text("Profile"));
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        // curved navigation bar
        bottomNavigationBar: CurvedNavigationBar(
          color: const Color.fromARGB(255, 253, 186, 203),
          height: 62,
          buttonBackgroundColor: Colors.pink,
          backgroundColor: Colors.transparent,
          index: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.person,
              color: Colors.white,
            ),
            Icon(
              Icons.remove_from_queue,
              color: Colors.white,
            ),
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            // Icon(Icons.person, color: Colors.white),
          ],
        ),
        body: getWidgets(_selectedIndex),
      ),
    );
  }
}
