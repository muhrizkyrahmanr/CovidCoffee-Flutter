import 'dart:convert';

List<TransaksiModel> transaksiFromJson(String str){
  final jsonData = jsonDecode(str);
  return List<TransaksiModel>.from(jsonData.map((x) => TransaksiModel.fromJson(x)));
}

class TransaksiModel {
  String kode_transaksi;
  String tanggal_transaksi;
  String total_bayar;
  String jenis_pesanan;
  String alamat_lengkap;
  String status_transaksi;
  String note;
  String note_cancel;
  String pembayaran;
  String ongkos_kirim;
  String id_pelanggan;
  String pengirim;

  TransaksiModel({
      this.kode_transaksi,
      this.tanggal_transaksi,
      this.total_bayar,
      this.jenis_pesanan,
      this.alamat_lengkap,
      this.status_transaksi,
      this.note,
      this.note_cancel,
      this.pembayaran,
      this.ongkos_kirim,
      this.id_pelanggan,
      this.pengirim
  });

  factory TransaksiModel.fromJson(Map<String, dynamic> json) => TransaksiModel(
    kode_transaksi: json['kode_transaksi'],
    tanggal_transaksi: json['tanggal_transaksi'],
    total_bayar: json['total_bayar'],
    jenis_pesanan: json['jenis_pesanan'],
    alamat_lengkap: json['alamat_lengkap'],
    status_transaksi: json['status_transaksi'],
    note: json['note'],
    note_cancel: json['note_cancel'],
    pembayaran: json['pembayaran'],
    ongkos_kirim: json['ongkos_kirim'],
    id_pelanggan: json['id_pelanggan'],
    pengirim: json['pengirim'],
  );

  Map<String, dynamic> toJson() => {
    'kode_transaksi': kode_transaksi,
    'tanggal_transaksi': tanggal_transaksi,
    'total_bayar': total_bayar,
    'jenis_pesanan': jenis_pesanan,
    'alamat_lengkap': alamat_lengkap,
    'status_transaksi': status_transaksi,
    'note': note,
    'note_cancel': note_cancel,
    'pembayaran': pembayaran,
    'ongkos_kirim': ongkos_kirim,
    'id_pelanggan': id_pelanggan,
    'pengirim': pengirim,
  };
}