import 'dart:convert';

List<KeranjangModel> keranjangFromJson(String str){
  final jsonData = jsonDecode(str);
  return List<KeranjangModel>.from(jsonData.map((x) => KeranjangModel.fromJson(x)));
}

class KeranjangModel{
  String id_keranjang;
  String nama_produk;
  String harga_produk;
  String qty;
  String gambar;
  String diskon;
  String id_pelanggan;

  KeranjangModel({
    this.id_keranjang,
    this.nama_produk,
    this.harga_produk,
    this.qty,
    this.gambar,
    this.diskon,
    this.id_pelanggan
  });

  factory KeranjangModel.fromJson(Map<String, dynamic> json) => KeranjangModel(
    id_keranjang: json['id_keranjang'],
    nama_produk: json['nama_produk'],
    harga_produk: json['harga_produk'],
    qty: json['qty'],
    gambar: json['gambar'],
    diskon: json['diskon'],
    id_pelanggan: json['id_pelanggan'],
  );

  Map<String, dynamic> toJson() => {
    'id_keranjang': id_keranjang,
    'nama_produk': nama_produk,
    'harga_produk': harga_produk,
    'qty': qty,
    'gambar': gambar,
    'diskon': diskon,
    'id_pelanggan': id_pelanggan,
  };

}