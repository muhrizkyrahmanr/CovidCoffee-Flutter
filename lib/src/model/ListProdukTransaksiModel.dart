import 'dart:convert';

List<ListProdukTransaksiModel> listProdukTransaksiFromJson(String str){
  final jsonData = jsonDecode(str);
  return List<ListProdukTransaksiModel>.from(jsonData.map((x) => ListProdukTransaksiModel.fromJson(x)));
}

class ListProdukTransaksiModel{
  String id;
  String jenis_kategori;
  String nama_produk;
  String harga_produk;
  String jumlah;
  String total;

  ListProdukTransaksiModel({
    this.id,
    this.jenis_kategori,
    this.nama_produk,
    this.harga_produk,
    this.jumlah,
    this.total,
  });

  factory ListProdukTransaksiModel.fromJson(Map<String, dynamic> json) => ListProdukTransaksiModel(
    id: json['id'],
    jenis_kategori: json['jenis_kategori'],
    nama_produk: json['nama_produk'],
    harga_produk: json['harga_produk'],
    jumlah: json['jumlah'],
    total: json['total'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'jenis_kategori': jenis_kategori,
    'nama_produk': nama_produk,
    'harga_produk': harga_produk,
    'jumlah': jumlah,
    'total': total,
  };

}