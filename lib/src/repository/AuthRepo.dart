import 'package:covidcoffee/src/provider/AuthProvider.dart';

class AuthRepo{
  final _authProvider = AuthProvider();

  Future login(String email, String password){
    return _authProvider.login(email, password);
  }

  Future registrasi(String email, String password, String nama, String no_telp){
    return _authProvider.register(email, password, nama, no_telp);
  }

  Future editPelanggan(String id, String nama, String no_telp, String password){
    return _authProvider.editPelanggan(id, nama, no_telp, password);
  }
}