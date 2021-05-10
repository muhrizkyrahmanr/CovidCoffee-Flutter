import 'package:covidcoffee/src/model/ListProdukTransaksiModel.dart';
import 'package:covidcoffee/src/model/TransaksiModel.dart';
import 'package:covidcoffee/src/provider/TransaksiProvider.dart';

class TransaksiRepo{
  final _provider = TransaksiProvider();

  Future getTotalBayar(String id_pelanggan, String wilayah_pengiriman){
    return _provider.getTotalBayar(id_pelanggan,wilayah_pengiriman);
  }

  Future kirimPesanan(Map<String, String> data){
    return _provider.kirimPesanan(data);
  }

  Future<List<TransaksiModel>> getTransaksi(String id_pelanggan){
    return _provider.getTransaksi(id_pelanggan);
  }

  Future<List<ListProdukTransaksiModel>> getListProdukTransaksi(String kode_transaksi, String id_pelanggan){
    return _provider.getListProdukTransaksi(kode_transaksi, id_pelanggan);
  }

}