import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderDetail extends StatelessWidget {
  String id_produk;
  String nama_produk;
  String kategori;
  String gambar;
  int harga_produk;

  HeaderDetail({
    this.id_produk,
    this.nama_produk,
    this.kategori,
    this.gambar,
    this.harga_produk,
  });

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$kategori',
            style: TextStyle(
                fontFamily: 'Varela',
                color: Colors.white
            ),
          ),
          RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white,
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.bold,
                    ),
                text: '$nama_produk'),
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Harga \n',
                      style: TextStyle(
                         fontFamily: 'Varela',
                      )
                  ),
                  TextSpan(
                    text: 'Rp. ${formatter.format(harga_produk)}',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Varela',
                        ),
                  ),
                ]
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Hero(
                  tag: id_produk,
                  child: Container(
                    height: 175.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(gambar),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(32.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 3.0,
                            blurRadius: 5.0,
                          )
                        ]
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
