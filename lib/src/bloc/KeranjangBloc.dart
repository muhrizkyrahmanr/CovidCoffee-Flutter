import 'package:covidcoffee/src/model/KeranjangModel.dart';
import 'package:covidcoffee/src/repository/KeranjangRepo.dart';
import 'package:rxdart/rxdart.dart';

class KeranjangBloc{
  final _cartRepo = KeranjangRepo();

  final _getAllKeranjang = PublishSubject<List<KeranjangModel>>();
  Observable<List<KeranjangModel>> get countKeranjang => _getAllKeranjang.stream;

  getKeranjang(String id_pelanggan) async{
    List<KeranjangModel> produk = await _cartRepo.getKeranjang(id_pelanggan);
    _getAllKeranjang.sink.add(produk);
  }

  getListPesanan(String id_pelanggan, String wilayah_pengiriman) async{
    List<KeranjangModel> produk = await _cartRepo.getListPesanan(id_pelanggan, wilayah_pengiriman);
    _getAllKeranjang.sink.add(produk);
  }

  tambahKeranjang(Map<String, String> data){
    return _cartRepo.tambahKeranjang(data);
  }

  ubahQtyKeranjang(Map<String, String> data){
    return _cartRepo.ubahQtyKeranjang(data);
  }

  hapusKeranjang(String id_keranjang){
    return _cartRepo.hapusKeranjang(id_keranjang);
  }

  totalKeranjang(String id_pelanggan){
    return _cartRepo.totalKeranjang(id_pelanggan);
  }

  dispose() async {
    await _getAllKeranjang.drain();
    _getAllKeranjang.close();
  }
}

final keranjangBloc = KeranjangBloc();