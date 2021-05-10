import 'dart:convert';

List<ProdukModel> produkFromJson(String str){
  final jsonData = jsonDecode(str);
  return List<ProdukModel>.from(jsonData.map((x) => ProdukModel.fromJson(x)));
}

class ProdukModel{
  String id_produk;
  String nama_produk;
  String harga_produk;
  String deskripsi;
  String gambar;
  String diskon;
  String kategori;

  ProdukModel({
    this.id_produk,
    this.nama_produk,
    this.harga_produk,
    this.deskripsi,
    this.gambar,
    this.diskon,
    this.kategori
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) => ProdukModel(
    id_produk: json['id_produk'],
    nama_produk: json['nama_produk'],
    harga_produk: json['harga_produk'],
    deskripsi: json['deskripsi'],
    gambar: json['gambar'],
    diskon: json['diskon'],
    kategori: json['kategori'],
  );

  Map<String, dynamic> toJson() => {
    'id_produk': id_produk,
    'nama_produk': nama_produk,
    'harga_produk': harga_produk,
    'deskripsi': deskripsi,
    'gambar': gambar,
    'diskon': diskon,
    'kategori': kategori,
  };

}