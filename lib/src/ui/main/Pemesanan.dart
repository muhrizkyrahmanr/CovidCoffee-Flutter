import 'package:covidcoffee/src/bloc/TransaksiBloc.dart';
import 'package:covidcoffee/src/ui/main/MainNavigation.dart';
import 'package:covidcoffee/src/ui/widget/pemesanan/Alamat.dart';
import 'package:covidcoffee/src/ui/widget/pemesanan/AppBar.dart';
import 'package:covidcoffee/src/ui/widget/pemesanan/Bayar.dart';
import 'package:covidcoffee/src/ui/widget/pemesanan/Catatan.dart';
import 'package:covidcoffee/src/ui/widget/pemesanan/JenisPesanan.dart';
import 'package:covidcoffee/src/ui/widget/pemesanan/ListPesanan.dart';
import 'package:covidcoffee/src/utility/SessionManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Pemesanan extends StatefulWidget {
  String id_pelanggan;

  Pemesanan({
    this.id_pelanggan,
  });

  @override
  _PemesananState createState() => _PemesananState();
}

class _PemesananState extends State<Pemesanan> {
  TextEditingController _noteController = TextEditingController();

  double lat;
  double lng;
  String alamat;
  String wilayah_pengiriman;
  String payment;
  String jenisPesanan;
  int isBayar;
  int totalBayar = 0;
  int totalOngkir = 0;
  bool isKirim = false;
  bool validAlamat;
  bool validPayment;
  bool validjenisPesanan;
  bool isAlamatPengiriman = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getAddress();
    _getPayment();
    _getTotalBayar();
    _getJenisPesanan();
  }

  @override
  Widget build(BuildContext context) {
    print(totalBayar);
    print(totalOngkir);

    final formatter = NumberFormat("#,###");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: !isKirim
          ? SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 60.0,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                            ),
                            child: Text(
                              'Jenis Pesanan',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          JenisPesanan(
                            jenisPesanan: jenisPesanan,
                            getJenisPesanan: _getJenisPesanan,
                            getreloadPemesanan:_reloadPemesanan,
                          ),
                          new Visibility(
                            visible: isAlamatPengiriman == true ? true : false,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 10.0,
                                    ),
                                    child: Text(
                                      'Alamat Pengiriman',
                                      style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Alamat(
                                    alamat: alamat,
                                    getAddress: _getAddress,
                                    getReloadPemesanan: _reloadPemesanan,
                                  ),
                                ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                            ),
                            child: Text(
                              'Ringkasan Pesanan',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ListPesanan(
                            id_pelanggan: widget.id_pelanggan,
                            ongkir: totalOngkir,
                            totalBayar: totalBayar,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                              top: 10.0,
                            ),
                            child: Text(
                              'Metode Pembayaran',
                              style: TextStyle(
                                fontFamily: 'Varela',
                                fontSize: 12.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Bayar(
                            payment: payment,
                            getPayment: _getPayment,
                          ),
                          Catatan(
                            noteController: _noteController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.1,
                    left: 0.1,
                    right: 0.1,
                    child: Container(
                      height: 60.0,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1.0,
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1.0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                width: 50.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Bayar :',
                                      style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    Text(
                                      'Rp. ${formatter.format(totalBayar + totalOngkir)}',
                                      style: TextStyle(
                                        fontFamily: 'Varela',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Material(
                            elevation: 0.0,
                            color: Colors.lightBlue[800],
                            borderRadius: BorderRadius.circular(5.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: () {
                                if(!validjenisPesanan){
                                  Fluttertoast.showToast(
                                      msg: "Jenis pesanan belum dipilih");
                                } else if (!validAlamat && jenisPesanan == "Antar") {
                                  Fluttertoast.showToast(
                                      msg: "Alamat kirim belum dipilih");
                                } else if (!validPayment) {
                                  Fluttertoast.showToast(
                                      msg: "Metode pembayaran belum dipilih");
                                } else if (totalBayar == 0) {
                                  Fluttertoast.showToast(
                                      msg: "Keranjang kosong!");
                                } else {
                                  _kirimPesanan();
                                }
                              },
                              child: Container(
                                width: 160.0,
                                child: Center(
                                  child: Text(
                                    'Pesan Sekarang',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _getAddress() async {
    Map _result = await SessionManager().getSessionAddress();

    setState(() {
      lat = _result['latitude'];
      lng = _result['longitude'];
      alamat = _result['alamat'];
      validAlamat = _result['hasDataAlamat'];
    });
  }

  _getPayment() async {
    Map _result = await SessionManager().getSessionPayment();

    setState(() {
      payment = _result['payment'];
      validPayment = _result['hasDataPayment'];
    });
  }

  _getJenisPesanan() async {
    Map _result = await SessionManager().getSessionJenisPesanan();
    setState(() {
      jenisPesanan = _result['jenisPesanan'];
      validjenisPesanan = _result['hasDatajenisPesanan'];
      if(jenisPesanan == "Jemput"){
        isAlamatPengiriman = false;
      }else if(jenisPesanan == "Antar"){
        isAlamatPengiriman = true;
      }
    });
  }

  _getTotalBayar() async {
    String jenis_pesanan = null;
    String wilayah_pengiriman = null;
    String latitude = null;
    String longitude = null;
    Map _result = await SessionManager().getSessionJenisPesanan();
    jenis_pesanan = _result['jenisPesanan'];
    if(_result['jenisPesanan'] == "Antar") {
      Map _resultt = await SessionManager().getSessionAddress();
      if (_resultt['wilayah_pengiriman'] != "Wilayah pengiriman belum terisi") {
        wilayah_pengiriman = _resultt['wilayah_pengiriman'];
      }
      if((lat != 0.0) && (lng != 0.0)){
        latitude = lat.toString();
        longitude = lng.toString();
      }
    }

    final res = await transaksiBloc.getTotalBayar(widget.id_pelanggan, jenis_pesanan, wilayah_pengiriman, latitude, longitude);
    bool status = res['status'];
    String message = res['message'];

    if (status) {
      setState(() {
        totalBayar = res['data']['total_bayar'];
        totalOngkir = res['data']['total_ongkir'];
      });
    } else {
      Fluttertoast.showToast(msg: message);
    }
  }

  _reloadPemesanan() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Pemesanan(
          id_pelanggan: widget.id_pelanggan,
        ),
      ),
    );
  }

  void _kirimPesanan() async {
    Map _result = await SessionManager().getSessionAddress();
    setState(() {
      isKirim = true;
    });

    Map<String, String> data = {
      'total_bayar': (totalBayar + totalOngkir).toString(),
      'jenis_pesanan': jenisPesanan,
      'alamat_kirim': alamat,
      'latitude': lat.toString(),
      'longtitude': lng.toString(),
      'id_pelanggan': widget.id_pelanggan,
      'note': _noteController.text,
      'payment': payment,
      'ongkir': totalOngkir.toString(),
      'wilayah_pengiriman': _result['wilayah_pengiriman'],
    };
    final result = await transaksiBloc.kirimPesanan(data);

    if (result['status']) {
      setState(() {
        isKirim = false;
      });

      SessionManager().removeSessionPayment();
      SessionManager().removeSessionJenisPesanan();
      SessionManager().removeSessionAddress();
      Fluttertoast.showToast(msg: result['message']);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigation(),
        ),
        (route) => false,
      );
    } else {
      setState(() {
        isKirim = false;
      });

      Fluttertoast.showToast(msg: result['message']);
    }
  }
}
