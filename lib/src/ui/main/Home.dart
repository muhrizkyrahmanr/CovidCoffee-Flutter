import 'package:badges/badges.dart';
import 'package:covidcoffee/src/bloc/KeranjangBloc.dart';
import 'package:covidcoffee/src/bloc/ProdukBloc.dart';
import 'package:covidcoffee/src/ui/main/Keranjang.dart';
import 'package:covidcoffee/src/ui/main/Produk.dart';
import 'package:covidcoffee/src/utility/SessionManager.dart';
import 'package:flutter/material.dart';

import 'Login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String kategori = null;
  String id_pelanggan;
  bool isLogin;

  int totalKeranjang = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _getLogin();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    produkBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    produkBloc.getProduk(kategori);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        textTheme: TextTheme(),
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Text(
          'Covid Coffee',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Varela',
          ),
          textAlign: TextAlign.start,
        ),
        actions: [
          Badge(
            badgeContent: Text(
              '$totalKeranjang',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.0,
              ),
            ),
            showBadge: totalKeranjang == 0 ? false : true,
            position: BadgePosition.topEnd(
              top: 5.0,
              end: 4.0,
            ),
            badgeColor: Colors.lightBlue[800],
            toAnimate: true,
            animationDuration: Duration(
              milliseconds: 200
            ),
            animationType: BadgeAnimationType.scale,
            child: IconButton(
              onPressed: () {
                if(isLogin) {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>
                          Keranjang(
                            id_pelanggan: id_pelanggan,
                            getTotalKeranjang: _getTotalKeranjang,
                          )
                  ));
                }else{
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                        (route) => false,
                  );
                }
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.grey[600],
              ),
            ),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.lightBlue[800],
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 20.0, right: 20.0),
          unselectedLabelColor: Color(0xFFCDCDCD),
          onTap: _getTabs,
          tabs: [
            Tab(
              child: Text(
                'Semua',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Minuman',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Kopi Kemasan',
                style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
            Produk(
              kategori: null,
              id_pelanggan: id_pelanggan,
              isLogin: isLogin,
              isVisible: false,
              wilayah_pengiriman: null,
              getTotalKeranjang: _getTotalKeranjang,
            ),
            Produk(
              kategori: 'Minuman',
              id_pelanggan: id_pelanggan,
              isLogin: isLogin,
              isVisible: true,
              wilayah_pengiriman: "Pengiriman Wilayah Kota Makassar",
              getTotalKeranjang: _getTotalKeranjang,
            ),
              Produk(
                kategori: 'Kopi Kemasan',
                id_pelanggan: id_pelanggan,
                isLogin: isLogin,
                isVisible: true,
                wilayah_pengiriman: "Pengiriman Wilayah Kota Makassar & Luar Kota Makassar",
                getTotalKeranjang: _getTotalKeranjang,
              ),
        ],
      ),
    );
  }

  _getTabs(int value) {
    if(value == 0){
      setState(() {
        kategori = null;
      });
    }else if(value == 1){
      setState(() {
        kategori = 'Minuman';
      });
    }else if(value == 2){
      setState(() {
        kategori = 'Kopi Kemasan';
      });
    }
  }

  _getLogin() async{
    bool _isLogin = await SessionManager().getIsLogin();
    Map _result = await SessionManager().getInfoPelanggan();
    setState(() {
      isLogin = _isLogin;
      id_pelanggan = _result['id_pelanggan'];
    });

    _getTotalKeranjang();
  }

  _getTotalKeranjang() async{
    setState(() {
      totalKeranjang = 0;
    });

    final res = await keranjangBloc.totalKeranjang(id_pelanggan);
    bool status = res['status'];
    String message = res['message'];

    if(status){
      print(message);
      setState(() {
        totalKeranjang = res['data']['totalkeranjang'];
      });
    }else{
      print(message);
    }
  }
}
