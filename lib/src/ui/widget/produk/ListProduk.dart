import 'package:covidcoffee/src/bloc/KeranjangBloc.dart';
import 'package:covidcoffee/src/ui/main/Login.dart';
import 'package:covidcoffee/src/utility/ShowToast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class ListProduk extends StatefulWidget {
  String id_produk;
  String nama_produk;
  String harga_produk;
  String gambar;
  bool isFavorite;
  String id_pelanggan;
  bool isLogin;
  VoidCallback getTotalKeranjang;

  ListProduk({
    this.id_produk,
    this.nama_produk,
    this.harga_produk,
    this.gambar,
    this.isFavorite,
    this.id_pelanggan,
    this.isLogin,
    this.getTotalKeranjang,
  });

  @override
  _ListProdukState createState() => _ListProdukState();
}

class _ListProdukState extends State<ListProduk> {
  final formatter = NumberFormat("#,###");

  int numQty = 1;
  int max;
  int min;
  bool add = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 10.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            15.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3.0,
              blurRadius: 5.0,
            )
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: widget.id_produk,
                  child: Container(
                    height: 120.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.gambar),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 6.0,
                right: 6.0,
              ),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: 'Varela',
                    color: Colors.lightBlue[800],
                  ),
                  text: '${widget.nama_produk}',
                ),
              ),
            ),
            SizedBox(
              height: 7.0,     
            ),
            Text(
              'Rp. ${formatter.format(int.parse(widget.harga_produk))}',
              style: TextStyle(
                fontFamily: 'Varela',
                color: Colors.lightBlue[800],
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                color: Color(0xFFEBEBEB),
                height: 1.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: _buildButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    if (!add) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(
            onTap: () {
              setState(() {
                add = true;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_basket,
                  size: 18.0,
                  color: Color(0xFFD17E50),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    color: Color(0xFFD17E50),
                    fontFamily: 'Varela',
                    fontSize: 14.0,
                  ),
                )
              ],
            ),
          )
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: (){
              if(numQty >1){
                setState(() {
                  numQty--;
                });
              }
            },
            child: Icon(
              Icons.remove_circle,
              color: Colors.red[600],
              size: 20.0,
            ),
          ),
          Text(
            '${numQty.toString()}',
            style: TextStyle(
              color: Color(0xFFD17E50),
              fontFamily: 'Varela',
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                numQty++;
              });
            },
            child: Icon(
              Icons.add_circle,
              color: Colors.green[600],
              size: 20.0,
            ),
          ),
          InkWell(
            onTap: () {
              if(!widget.isLogin){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Login(),
                ));
              }else{
                _tambahKeranjang();
              }
            },
            child: Icon(
              Icons.check,
              color: Colors.green[600],
              size: 20.0,
            ),
          ),
          InkWell(
            onTap: (){
              setState(() {
                add = false;
              });
            },
            child: Icon(
              Icons.close,
              color: Colors.red[600],
              size: 20.0,
            ),
          )
        ],
      );
    }
  }

  _tambahKeranjang() async{
    Map<String, String> data = {
      'jumlah': numQty.toString(),
      'id_produk': widget.id_produk,
      'id_pelanggan': widget.id_pelanggan,
    };

    final res = await keranjangBloc.tambahKeranjang(data);
    bool status = res['status'];
    String message = res['message'];

    if(status){
      print(message);
      setState(() {
        add = false;
      });

      widget.getTotalKeranjang();

      Fluttertoast.showToast(msg:message);
    } else {
      print(message);

      Fluttertoast.showToast(msg:message);
    }
  }
}
