import 'package:covidcoffee/src/bloc/TransaksiBloc.dart';
import 'package:covidcoffee/src/model/ListProdukTransaksiModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListPesanan extends StatefulWidget {
  String kode_transaksi;
  String id_pelanggan;
  int totalBayar;
  int ongkir;
  String wilayah_pengiriman;

  ListPesanan({
    this.kode_transaksi,
    this.id_pelanggan,
    this.totalBayar,
    this.ongkir,
    this.wilayah_pengiriman,
  });

  @override
  _ListPesananState createState() => _ListPesananState();
}

class _ListPesananState extends State<ListPesanan> {
  bool isVisible = false;

  final formatter = NumberFormat("#,###");

  @override
  void initState() {
    transaksiBloc.getListProdukTransaksi(widget.kode_transaksi, widget.id_pelanggan);
    super.initState();
  }

  @override
  void dispose() {
    transaksiBloc.disposeProdukTransaksi();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0,),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder(
              stream: transaksiBloc.countListProdukTransaksi,
              builder: (context, AsyncSnapshot<List<ListProdukTransaksiModel>> snap) {
                if (snap.hasData) {
                  if (snap.data.isEmpty) {
                    return Center(
                      child: Text('Tidak ada produk'),
                    );
                  } else {
                    return buildItem(context, snap);
                  }
                } else if (snap.hasError) {
                  return Text(snap.error.toString());
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
                right: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rp. ${formatter.format(widget.totalBayar - widget.ongkir)}',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 13.0,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
                right: 5.0,
              ),
              child:new Visibility(
                visible: widget.ongkir != 0 ? true : false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ongkos Kirim',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Rp. ${formatter.format(widget.ongkir)}',
                      style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItem(
      BuildContext context, AsyncSnapshot<List<ListProdukTransaksiModel>> snap) {
    final formatter = NumberFormat("#,###");

    return ListView.separated(
      itemCount: snap.data.length,
      separatorBuilder: (context, i){
        return Divider();
      },
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, i){
        final data = snap.data[i];

        return Padding(
          padding: EdgeInsets.only(
            top: 5.0,
            bottom: 5.0,
            left: 5.0,
            right: 5.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'x${data.jumlah}',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      color: Colors.grey[800],
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(width: 10.0,),
                  Align(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        softWrap: true,
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Varela',
                            color: Colors.grey[800],
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          text: data.nama_produk,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${formatter.format(int.parse(data.harga_produk) * int.parse(data.jumlah))}',
                    style: TextStyle(
                      fontFamily: 'Varela',
                      fontSize: 13.0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}