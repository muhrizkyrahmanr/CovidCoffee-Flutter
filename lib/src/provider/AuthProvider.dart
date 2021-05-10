import 'dart:convert';

import 'package:covidcoffee/src/utility/BaseURL.dart';
import 'package:http/http.dart';

class AuthProvider{
  Client _client = Client();

  Future<dynamic> login(String email, String password) async{
    final res = await _client.post(BaseURL.Login,
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': email,
        'password': password,
      }
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> register(String email, String password, String nama, String no_telp) async{
    final res = await _client.post(BaseURL.Registrasi,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'email': email,
          'password': password,
          'nama': nama,
          'no_telp': no_telp,
        }
    );
    return jsonDecode(res.body);
  }

  Future<dynamic> editPelanggan(String id, String nama, String no_telp, String password) async{
    final res = await _client.post(BaseURL.EditPelanggan,
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'id': id,
          'nama': nama,
          'no_telp': no_telp,
          'password': password,
        }
    );
    return jsonDecode(res.body);
  }
}