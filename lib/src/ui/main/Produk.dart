import 'package:covidcoffee/src/bloc/ProdukBloc.dart';
import 'package:covidcoffee/src/model/ProdukModel.dart';
import 'package:covidcoffee/src/ui/main/Detail.dart';
import 'package:covidcoffee/src/ui/widget/produk/ListProduk.dart';
import 'package:flutter/material.dart';

class Produk extends StatefulWidget {
  String kategori;
  String id_pelanggan;
  bool isLogin;
  bool isVisible;
  String wilayah_pengiriman;
  VoidCallback getTotalKeranjang;

  Produk({
    this.kategori,
    this.id_pelanggan,
    this.isLogin,
    this.isVisible,
    this.wilayah_pengiriman,
    this.getTotalKeranjang,
  });

  @override
  _ProdukState createState() => _ProdukState();
}

class _ProdukState extends State<Produk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Column(children: [
        new Visibility(
          visible: widget.isVisible,
            child: Container(
              height:30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.info_outline,
                    color: Color(0xFFCDCDCD),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: widget.isVisible != false ? Text(widget.wilayah_pengiriman,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFCDCDCD)
                        )
                    ) : null,
                  )
                ],
              ),
            ),
        ),
          new Expanded(
            child: StreamBuilder(
              stream: produkBloc.countProduk,
              builder: (context, AsyncSnapshot<List<ProdukModel>> snapshot){
                if(snapshot.hasData){
                  if(snapshot.data.isEmpty){
                    return Center(
                      child: Text('Tidak ada Produk'),
                    );
                  }else{
                    return _buildListProduk(snapshot);
                  }
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }

                return Center(child: CircularProgressIndicator(),);
                },
              ),
          )
      ])
    );
  }

  Widget _buildListProduk(AsyncSnapshot<List<ProdukModel>> snapshot){
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          childAspectRatio:   0.85,
        ),
        scrollDirection: Axis.vertical,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index){
          final data = snapshot.data[index];

          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Detail(
                  id_produk: data.id_produk,
                  nama_produk: data.nama_produk,
                  kategori: data.kategori,
                  deskripsi: data.deskripsi,
                  gambar: data.gambar,
                  harga_produk: int.parse(data.harga_produk),
                  getTotalKeranjang: widget.getTotalKeranjang,
                )
              ));
            },
            child: ListProduk(
              id_produk: data.id_produk,
              nama_produk: data.nama_produk,
              harga_produk: data.harga_produk,
              gambar: data.gambar,
              isFavorite: false,
              id_pelanggan: widget.id_pelanggan,
              isLogin: widget.isLogin,
              getTotalKeranjang: widget.getTotalKeranjang,
            ),
          );
        }
    );
  }
}
