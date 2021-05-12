import 'package:covidcoffee/src/model/KeranjangModel.dart';
import 'package:covidcoffee/src/model/ProdukModel.dart';
import 'package:covidcoffee/src/repository/KeranjangRepo.dart';
import 'package:rxdart/rxdart.dart';

class ListPesananBloc{
  final _pesananRepo = KeranjangRepo();

  final _getAllListPesanan = PublishSubject<List<KeranjangModel>>();
  Observable<List<KeranjangModel>> get countListPesanan => _getAllListPesanan.stream;


  getListPesanan(String id_pelanggan, String jenis_pesanan, String wilayah_pengiriman) async{
    List<KeranjangModel> produk = await _pesananRepo.getListPesanan(id_pelanggan, jenis_pesanan, wilayah_pengiriman);
    _getAllListPesanan.sink.add(produk);
  }

  dispose() async {
    await _getAllListPesanan.drain();
    _getAllListPesanan.close();
  }
}

final listPesananBloc = ListPesananBloc();