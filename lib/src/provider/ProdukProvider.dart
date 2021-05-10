import 'package:covidcoffee/src/model/ProdukModel.dart';
import 'package:covidcoffee/src/utility/BaseURL.dart';
import 'package:http/http.dart' show Client;
import 'package:flutter/foundation.dart' show compute;

class ProdukProvider{
  Client _client = Client();

  Future<List<ProdukModel>> getProduk(String kategori) async {
    var uri = Uri.parse(BaseURL.Produk);

    uri = uri.replace(queryParameters: <String, String>{
      'kategori': kategori,
    });

    final res = await _client.get(uri, headers:{
      'Accept': 'application/json',
    });

    if(res.statusCode == 200){
      return compute(produkFromJson, res.body);
    }else{
      return [];
    }
  }
}

