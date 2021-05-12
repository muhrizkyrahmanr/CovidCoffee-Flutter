import 'package:covidcoffee/src/model/TransaksiModel.dart';
import 'package:covidcoffee/src/ui/main/DetailTransaksi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget TransaksiItem({BuildContext context, AsyncSnapshot<List<TransaksiModel>> snapshot}){
  return Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data.length,
      itemBuilder: (context, i) {
        final data = snapshot.data[i];

        Color statusColor;
        IconData statusIcon;

        if (data.status_transaksi == "Belum Dibayar") {
          statusColor = Colors.red;
          statusIcon = Icons.attach_money;
        }else if (data.status_transaksi == "Dipesan") {
          statusColor = Colors.orange;
          statusIcon = Icons.assignment_late;
        } else if (data.status_transaksi == "Diproses") {
          statusColor = Colors.blue;
          statusIcon = Icons.sync;
        } else if (data.status_transaksi == "Dikirim") {
          statusColor = Colors.lightBlueAccent;
          statusIcon = Icons.motorcycle;
        } else if (data.status_transaksi == "Diterima") {
          statusColor = Colors.green;
          statusIcon = Icons.assignment_turned_in;
        } else {
          statusColor = Colors.red;
          statusIcon = Icons.cancel;
        }

        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailTransaksi(
                  kode_transaksi: data.kode_transaksi,
                  tanggal_transaksi: data.tanggal_transaksi,
                  total_bayar: data.total_bayar,
                  jenis_pesanan: data.jenis_pesanan,
                  alamat_lengkap: data.alamat_lengkap,
                  status_transaksi: data.status_transaksi,
                  note: data.note,
                  note_cancel: data.note_cancel,
                  pembayaran: data.pembayaran,
                  ongkos_kirim: data.ongkos_kirim,
                  id_pelanggan: data.id_pelanggan,
                  pengirim: data.pengirim,
                )
            ));
          },
          child: Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 5.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,),
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3.0,
                    blurRadius: 5.0,
                  )
                ],
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    height: 80.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                      ),
                    ),
                    child: Icon(
                      statusIcon,
                      color: statusColor,
                      size: 32.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '#${data.kode_transaksi}',
                            style: TextStyle(
                              fontFamily: 'Varela',
                              color: Colors.lightBlue[600],
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '${data.tanggal_transaksi}',
                            style: TextStyle(
                              fontFamily: 'Varela',
                              color: Colors.grey,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.grey[600],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          text:  data.jenis_pesanan == "Jemput" ? 'Jemput atau Ambil di Toko' : '${data.alamat_lengkap}',
                        ),
                      ),

                    ],
                  ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}