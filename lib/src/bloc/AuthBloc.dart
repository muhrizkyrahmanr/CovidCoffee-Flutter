import 'package:covidcoffee/src/repository/AuthRepo.dart';

class AuthBloc{
  final _authRepo = AuthRepo();

  login(String email, String password){
    return _authRepo.login(email, password);
  }

  registrasi(String email, String password, String nama, String no_telp){
    return _authRepo.registrasi(email, password, nama, no_telp);
  }

  editPelanggan(String id, String nama, String no_telp, String password){
    return _authRepo.editPelanggan(id, nama, no_telp, password);
  }
}

final authBloc = AuthBloc();