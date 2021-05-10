import 'package:covidcoffee/src/bloc/KeranjangBloc.dart';
import 'package:covidcoffee/src/ui/widget/detail/AddCartButton.dart';
import 'package:covidcoffee/src/ui/widget/detail/AppBarDetail.dart';
import 'package:covidcoffee/src/ui/widget/detail/CartCounter.dart';
import 'package:covidcoffee/src/ui/widget/detail/Deskripsi.dart';
import 'package:covidcoffee/src/ui/widget/detail/HeaderDetail.dart';
import 'package:covidcoffee/src/utility/SessionManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Keranjang.dart';
import 'Login.dart';

class Detail extends StatefulWidget {
  String id_produk;
  String nama_produk;
  String kategori;
  String deskripsi;
  String gambar;
  int harga_produk;
  VoidCallback getTotalKeranjang;

  Detail({
    this.id_produk,
    this.nama_produk,
    this.kategori,
    this.deskripsi,
    this.gambar,
    this.harga_produk,
    this.getTotalKeranjang,
  });

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int numQty = 1;
  int totalKeranjang;
  String id_pelanggan;
  bool isLogin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLogin();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        widget.getTotalKeranjang();

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue[800],
        appBar: AppBarDetail(
            context: context,
            totalKeranjang: totalKeranjang,
            id_pelanggan: id_pelanggan,
            isLogin: isLogin,
            getTotalKeranjang: _getTotalKeranjang,
            getTotalKeranjangHome: widget.getTotalKeranjang,
        ),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 220.0,
                    ),
                    padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: 20.0,
                      right: 20.0,
                    ),
                    width: size.width,
                    height: size.height,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24.0),
                          topRight: Radius.circular(24.0),
                        )),
                    child: Column(
                      children: [
                        Deskripsi(
                          deskripsi: widget.deskripsi,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CartCounter(
                                  icon: Icons.remove,
                                  color: Colors.red[600],
                                  press: () {
                                    if (numQty > 1) {
                                      setState(() {
                                        numQty--;
                                      });
                                    }
                                  },
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0 / 2),
                                  child: Text(
                                    numQty.toString().padLeft(2, "0"),
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                CartCounter(
                                  icon: Icons.add,
                                  color: Colors.green[600],
                                  press: () {
                                    setState(() {
                                      numQty++;
                                    });
                                  },
                                ),
                              ],
                            ),
                            // Favorite(),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        AddCartButton(
                          tambahKeranjang: _tambahKeranjang,
                          pesanSekarang: _pesanSekarang,
                          isLogin: isLogin,
                        ),
                      ],
                    ),
                  ),
                  HeaderDetail(
                    id_produk: widget.id_produk,
                    nama_produk: widget.nama_produk,
                    kategori: widget.kategori,
                    harga_produk: widget.harga_produk,
                    gambar: widget.gambar,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _getTotalKeranjang() async {
    setState(() {
      totalKeranjang = 0;
    });

    final res = await keranjangBloc.totalKeranjang(id_pelanggan);
    bool status = res['status'];
    String message = res['message'];

    if (status) {
      print(message);
      setState(() {
        totalKeranjang = res['data']['totalkeranjang'];
      });
    } else {
      print(message);
    }
  }

  _getLogin() async {
    bool _isLogin = await SessionManager().getIsLogin();
    Map _result = await SessionManager().getInfoPelanggan();
    setState(() {
      isLogin = _isLogin;
      id_pelanggan = _result['id_pelanggan'];
    });

    _getTotalKeranjang();
  }

  _tambahKeranjang() async {
    Map<String, String> data = {
      'jumlah': numQty.toString(),
      'id_produk': widget.id_produk,
      'id_pelanggan': id_pelanggan,
    };

    final res = await keranjangBloc.tambahKeranjang(data);
    bool status = res['status'];
    String message = res['message'];

    if (status) {
      _getTotalKeranjang();
      setState(() {
        numQty = 1;
      });

      Fluttertoast.showToast(msg:message);
    } else {
      print(message);

      Fluttertoast.showToast(msg:message);
    }
  }

  _pesanSekarang() async {
    Map<String, String> data = {
      'jumlah': numQty.toString(),
      'id_produk': widget.id_produk,
      'id_pelanggan': id_pelanggan,
    };

    final res = await keranjangBloc.tambahKeranjang(data);
    bool status = res['status'];
    String message = res['message'];

    if (status) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              Keranjang(
                id_pelanggan: id_pelanggan,
                getTotalKeranjang: _getTotalKeranjang,
              )
      ));
    } else {
      print(message);

      Fluttertoast.showToast(msg:message);
    }
  }
}
