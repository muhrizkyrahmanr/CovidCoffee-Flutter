import 'package:covidcoffee/src/utility/SessionManager.dart';
import 'package:flutter/material.dart';
import 'package:bmnav/bmnav.dart' as bmnav;

import 'Akun.dart';
import 'Home.dart';
import 'Login.dart';
import 'Transaksi.dart';

class MainNavigation extends StatefulWidget {
  String loadPage;
  String id_pelanggan;

  MainNavigation({this.loadPage, this.id_pelanggan});

  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex;
  var page;

  bool isLogin;
  String id_pelanggan;

  @override
  void initState() {
    _getLogin();
    if (widget.loadPage == "Transaksi") {
      _currentIndex = 1;
      page = Transaksi(
        id_pelanggan: widget.id_pelanggan,
      );
    } else if (widget.loadPage == "Akun") {
      _currentIndex = 2;
      page = Akun();
    } else {
      _currentIndex = 0;
      page = Home();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(isLogin);

    return Scaffold(
      body: page,
      bottomNavigationBar: bmnav.BottomNav(
        color: Colors.white,
        labelStyle: bmnav.LabelStyle(
            visible: true,
            showOnSelect: false,
            onSelectTextStyle: TextStyle(
              color: Colors.grey,
              height: 1.8,
            ),
            textStyle: TextStyle(
              color: Colors.grey,
              height: 1.8,
            )),
        iconStyle: bmnav.IconStyle(
          color: Colors.grey[400],
          onSelectSize: 22.0,
          size: 22.0,
        ),
        elevation: 6.0,
        onTap: (i) {
          _currentIndex = i;
          _currentPage(i);
        },
        index: _currentIndex,
        items: [
          bmnav.BottomNavItem(Icons.home, label: 'Home'),
          bmnav.BottomNavItem(Icons.assignment, label: 'Transaksi'),
          bmnav.BottomNavItem(Icons.person, label: 'Akun'),
        ],
      ),
    );
  }

  void _currentPage(int i) {
    if (i == 0) {
      setState(() {
        page = Home();
      });
    } else if (i == 1) {
      if (isLogin) {
        setState(() {
          page = Transaksi(
            id_pelanggan: id_pelanggan,
          );
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login(
                loadPage: "Transaksi",
              ),
            ),
            (route) => false);
      }
    } else {
      if (isLogin) {
        setState(() {
          page = Akun();
        });
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => Login(
                loadPage: "Akun",
              ),
            ),
            (route) => false);
      }
    }
  }

  _getLogin() async {
    bool _isLogin = await SessionManager().getIsLogin();
    Map _result = await SessionManager().getInfoPelanggan();
    setState(() {
      isLogin = _isLogin;
      id_pelanggan = _result['id_pelanggan'];
    });
  }
}
