import 'package:covidcoffee/src/provider/ProdukProvider.dart';
import 'package:covidcoffee/src/model/ProdukModel.dart';

class ProdukRepo{
  final _provider = ProdukProvider();

  Future<List<ProdukModel>> getProduk(String kategori){
    return _provider.getProduk(kategori);
  }

}