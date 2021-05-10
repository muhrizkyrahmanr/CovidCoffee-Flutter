import 'package:covidcoffee/src/ui/widget/detail_transaksi/CatatanPembatalan.dart';
import 'package:covidcoffee/src/ui/widget/detail_transaksi/ListPesanan.dart';
import 'package:covidcoffee/src/ui/widget/detail_transaksi//AppBar.dart';
import 'package:covidcoffee/src/ui/widget/detail_transaksi/Bayar.dart';
import 'package:covidcoffee/src/ui/widget/detail_transaksi/Catatan.dart';
import 'package:covidcoffee/src/ui/widget/detail_transaksi/Alamat.dart';
import 'package:covidcoffee/src/ui/widget/detail_transaksi/Pengirim.dart';
import 'package:covidcoffee/src/ui/widget/detail_transaksi/StatusPesanan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailTransaksi extends StatefulWidget {
  String kode_transaksi;
  String tanggal_transaksi;
  String total_bayar;
  String alamat_lengkap;
  String status_transaksi;
  String note;
  String note_cancel;
  String pembayaran;
  String ongkos_kirim;
  String id_pelanggan;
  String pengirim;

  DetailTransaksi({
      this.kode_transaksi,
      this.tanggal_transaksi,
      this.total_bayar,
      this.alamat_lengkap,
      this.status_transaksi,
      this.note,
      this.note_cancel,
      this.pembayaran,
      this.ongkos_kirim,
      this.id_pelanggan,
      this.pengirim
  });

  @override
  _DetailTransaksiState createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(
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
                    StatusPesanan(
                      status: widget.status_transaksi,
                      kode_transaksi: widget.kode_transaksi
                    ),
                    if(widget.status_transaksi == "Dibatalkan") CatatanPembatalan(
                      noteCancel: widget.note_cancel,
                    ),
                    if(widget.status_transaksi == "Dikirim" || widget.status_transaksi == "Diterima") Pengirim(
                      pengirim: widget.pengirim,
                    ),
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
                      alamat: widget.alamat_lengkap,
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
                      kode_transaksi: widget.kode_transaksi,
                      id_pelanggan: widget.id_pelanggan,
                      ongkir: int.parse(widget.ongkos_kirim),
                      totalBayar: int.parse(widget.total_bayar),
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
                      payment: widget.pembayaran,
                    ),
                    Catatan(
                      note: widget.note,
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
                                'Rp. ${formatter.format(int.parse(widget.total_bayar))}',
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
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
