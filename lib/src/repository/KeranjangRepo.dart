import 'package:covidcoffee/src/model/KeranjangModel.dart';
import 'package:covidcoffee/src/provider/KeranjangProvider.dart';

class KeranjangRepo{
  final _cartProvider = KeranjangProvider();

  Future<List<KeranjangModel>> getKeranjang(String id_pelanggan){
    return _cartProvider.getKeranjang(id_pelanggan);
  }

  Future<List<KeranjangModel>> getListPesanan(String id_pelanggan, String wilayah_pengiriman){
    return _cartProvider.getListPesanan(id_pelanggan, wilayah_pengiriman);
  }

  Future tambahKeranjang(Map<String, String> data){
    return _cartProvider.tambahKeranjang(data);
  }

  Future ubahQtyKeranjang(Map<String, String> data){
    return _cartProvider.ubahQtyKeranjang(data);
  }

  Future hapusKeranjang(String id_keranjang){
    return _cartProvider.hapusKeranjang(id_keranjang);
  }

  Future totalKeranjang(String id_pelanggan){
    return _cartProvider.totalKeranjang(id_pelanggan);
  }
}