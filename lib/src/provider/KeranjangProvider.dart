import 'dart:convert';

import 'package:covidcoffee/src/model/KeranjangModel.dart';
import 'package:covidcoffee/src/utility/BaseURL.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class KeranjangProvider{
  Client _client = Client();

  Future<List<KeranjangModel>> getKeranjang(String id_pelanggan) async {
    var uri = Uri.parse(BaseURL.Keranjang);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await _client.get(uri, headers:{
      'Accept': 'application/json',
    });

    if(res.statusCode == 200){
      return compute(keranjangFromJson, res.body);
    }else{
      return [];
    }
  }

  Future<List<KeranjangModel>> getListPesanan(String id_pelanggan, String jenis_pesanan,String wilayah_pengiriman) async {
    var uri = Uri.parse(BaseURL.Keranjang);

    if((jenis_pesanan == "Jemput" || jenis_pesanan == "") && (id_pelanggan == "Wilayah pengiriman belum terisi" || wilayah_pengiriman == "")) {
      uri = uri.replace(queryParameters: <String, String>{
        'id_pelanggan': id_pelanggan,
      });
    }else{
      uri = uri.replace(queryParameters: <String, String>{
        'id_pelanggan': id_pelanggan,
        'jenis_pesanan': jenis_pesanan,
        'wilayah_pengiriman': wilayah_pengiriman,
      });
    }

    final res = await _client.get(uri, headers:{
      'Accept': 'application/json',
    });

    if(res.statusCode == 200){
      return compute(keranjangFromJson, res.body);
    }else{
      return [];
    }
  }

  Future<dynamic> tambahKeranjang(Map<String, String> data) async{
    final res = await _client.post(BaseURL.TambahKeranjang,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'jumlah': data['jumlah'],
        'id_produk': data['id_produk'],
        'id_pelanggan': data['id_pelanggan'],
      }
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> ubahQtyKeranjang(Map<String, String> data) async{
    final res = await _client.post(BaseURL.UbahKeranjang,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'id_keranjang': data['id_keranjang'],
          'qty': data['qty'],
        }
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> hapusKeranjang(String id_keranjang) async{
    final res = await _client.post(BaseURL.HapusKeranjang,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'id_keranjang': id_keranjang
        }
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> totalKeranjang(String id_pelanggan) async{
    var uri = Uri.parse(BaseURL.TotalKeranjang);

    uri = uri.replace(queryParameters: <String, String>{
      'id_pelanggan': id_pelanggan,
    });

    final res = await _client.get(uri, headers: {
          'Accept': 'application/json',
        },
    );
    return jsonDecode(res.body);
  }
}