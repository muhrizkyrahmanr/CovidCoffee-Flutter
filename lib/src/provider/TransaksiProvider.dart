import 'dart:convert';

import 'package:covidcoffee/src/model/ListProdukTransaksiModel.dart';
import 'package:flutter/foundation.dart' show compute;
import 'package:covidcoffee/src/model/TransaksiModel.dart';
import 'package:covidcoffee/src/utility/BaseURL.dart';
import 'package:http/http.dart';

class TransaksiProvider{
  Client client = Client();

  Future<dynamic> getTotalBayar(String id_pelanggan, String wilayah_pengiriman) async{
    var uri = Uri.parse(BaseURL.TotalBayar);

    uri = uri.replace(queryParameters: <String, String> {
      'id_pelanggan': id_pelanggan,
      'wilayah_pengiriman': wilayah_pengiriman,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    return jsonDecode(res.body);
  }

  Future<dynamic> kirimPesanan(Map<String, String> data) async{
    final res = await client.post(BaseURL.KirimPesanan, headers: {
      'Accept': 'application/json',
    },

    body: {
      'total_bayar': data['total_bayar'],
      'alamat_kirim': data['alamat_kirim'],
      'latitude': data['latitude'],
      'longtitude': data['longtitude'],
      'id_pelanggan': data['id_pelanggan'],
      'note': data['note'],
      'payment': data['payment'],
      'ongkir': data['ongkir'],
      'wilayah_pengiriman': data['wilayah_pengiriman'],
    }
  );
    return jsonDecode(res.body);
  }

  Future<List<TransaksiModel>> getTransaksi(String id_pelanggan) async{
    var uri = Uri.parse(BaseURL.Transaksi);

    uri = uri.replace(queryParameters: <String, String> {
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    if(res.statusCode == 200){
      return compute(transaksiFromJson, res.body);
    }
    return [];
  }

  Future<List<ListProdukTransaksiModel>> getListProdukTransaksi(String kode_transaksi, String id_pelanggan) async{
    var uri = Uri.parse(BaseURL.ListProdukTransaksi);

    uri = uri.replace(queryParameters: <String, String> {
      'kode_transaksi': kode_transaksi,
      'id_pelanggan': id_pelanggan,
    });

    final res = await client.get(uri, headers: {
      'Accept': 'application/json',
    });

    if(res.statusCode == 200){
      return compute(listProdukTransaksiFromJson, res.body);
    }
    return [];
  }
}