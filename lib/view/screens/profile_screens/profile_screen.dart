// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/view/screens/profile_screens/points_screen.dart';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../controller/Auth/auth.dart';
import '../../../controller/providers/providers.dart';
import '../../../model/models.dart';
import '../screens.dart';

class Profile6 extends StatefulWidget {
  static const routeName = '/Profile6';

  const Profile6({super.key});

  @override
  State<Profile6> createState() => _Profile6State();
}

class _Profile6State extends State<Profile6> {
  //
  @override
  void initState() {
    _getUserInfo();
    super.initState();
    _getImage();
  }

  Future<void> _getUserInfo() async {
    await Provider.of<UserProvider>(context, listen: false).getUserDetails();
  }

  Future<void> _getImage() async {
    try {
      final secureStorage = SecureStorageService();
      var thisImage = XFile(await secureStorage.getimage());

      setState(() {
        _pickedImage = thisImage;
      });
    } catch (e) {
      return;
    }
  }

  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImageFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = pickedImageFile;
      });
      final secureStorage = SecureStorageService();
      await secureStorage.storeImage(_pickedImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final thisUser = Provider.of<UserProvider>(context, listen: true).getUser;
    double widthC = MediaQuery.of(context).size.width * 100;
    return RefreshIndicator(
      color: Colors.pink,
      onRefresh: () {
        return Provider.of<UserProvider>(context, listen: false)
            .getUserDetails();
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildHeader(),
              _buildMainInfo(thisUser, context, widthC),
              const SizedBox(height: 10.0),
              _buildInfo(thisUser, context, widthC),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: <Widget>[
        Ink(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
            gradient: LinearGradient(colors: [
              Colors.red,
              Colors.pink,
              Colors.orange,
              Colors.pinkAccent,
            ]),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 140),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: Colors.white,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    gradient: const LinearGradient(colors: [
                      Colors.red,
                      Colors.pink,
                      Colors.orange,
                      Colors.pinkAccent,
                    ]),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(85),
                        child: _pickedImage == null
                            ? Image.asset(
                                'assets/images/strawberry.png',
                                width: 85,
                                height: 85,
                                fit: BoxFit.fill,
                              )
                            : Image.file(
                                File(_pickedImage!.path),
                                width: 85,
                                height: 85,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMainInfo(User thisUser, BuildContext context, double width) {
    return Container(
      width: width,
      margin: const EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              thisUser.userName,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfo(User thisUser, BuildContext context, double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PointsScreen(),
                        )),
                    child: ListTile(
                      leading:
                          const Icon(Icons.card_giftcard, color: Colors.red),
                      title: Text(
                        AppLocalizations.of(context)!.my_points,
                      ),
                      subtitle: Text(
                        "${thisUser.points} ${AppLocalizations.of(context)!.sp}",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      titleTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.email, color: Colors.red),
                    title: Text(
                      AppLocalizations.of(context)!.email_profile,
                    ),
                    subtitle: Text(thisUser.email.toString()),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.phone, color: Colors.red),
                    title: Text(
                      AppLocalizations.of(context)!.phoneNumber_profile,
                    ),
                    subtitle: Text(thisUser.phoneNumber),
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    leading: const Icon(Icons.my_location, color: Colors.red),
                    title: Text(
                      AppLocalizations.of(context)!.location_profile,
                    ),
                    subtitle: Text(thisUser.location),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () async {
                      final secureStorage = SecureStorageService();
                      await secureStorage.storeCondition("");
                      await secureStorage.storeEmail("");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IntroViewsPage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: Text(
                          AppLocalizations.of(context)!.logout,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
