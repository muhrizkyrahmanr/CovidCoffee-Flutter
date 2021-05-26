import 'package:covidcoffee/src/model/ListProdukTransaksiModel.dart';
import 'package:covidcoffee/src/model/TransaksiModel.dart';
import 'package:covidcoffee/src/repository/TransaksiRepo.dart';
import 'package:rxdart/rxdart.dart';

class TransaksiBloc{
  final _repo = TransaksiRepo();

  final _getTransaksi = PublishSubject<List<TransaksiModel>>();
  Stream<List<TransaksiModel>> get countTransaksi => _getTransaksi.stream;

  final _getListProdukTransaksi = PublishSubject<List<ListProdukTransaksiModel>>();
  Stream<List<ListProdukTransaksiModel>> get countListProdukTransaksi => _getListProdukTransaksi.stream;

  getTotalBayar(String id_pelanggan, String jenis_pesanan, String wilayah_pengiriman, String latitude, String longitude){
    return _repo.getTotalBayar(id_pelanggan, jenis_pesanan, wilayah_pengiriman, latitude, longitude);
  }

  kirimPesanan(Map<String, String> data){
    return _repo.kirimPesanan(data);
  }

  getTransaksi(String id_pelanggan) async{
    List<TransaksiModel> trf = await _repo.getTransaksi(id_pelanggan);
    _getTransaksi.sink.add(trf);
  }

  getListProdukTransaksi(String kode_transaksi, String id_pelanggan) async{
    List<ListProdukTransaksiModel> lpt = await _repo.getListProdukTransaksi(kode_transaksi, id_pelanggan);
    _getListProdukTransaksi.sink.add(lpt);
  }

  dispose() async{
    await _getTransaksi.drain();
    _getTransaksi.close();
  }

  disposeProdukTransaksi() async{
    await _getListProdukTransaksi.drain();
    _getListProdukTransaksi.close();
  }

  uploadBuktiPembayaran(Map<String, String> data){
    return _repo.uploadBuktiPembayaran(data);
  }
}

final transaksiBloc = TransaksiBloc();