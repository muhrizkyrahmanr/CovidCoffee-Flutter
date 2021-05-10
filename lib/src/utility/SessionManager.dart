import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {

  setSession(String id_pelanggan, String nama, String no_telp, String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('is_login', true);
    preferences.setString("id_pelanggan", id_pelanggan);
    preferences.setString("nama", nama);
    preferences.setString("no_telp", no_telp);
    preferences.setString("email", email);
  }

  Future<bool> getIsLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("is_login") ?? false;
  }

  getInfoPelanggan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map data = {
      'id_pelanggan': preferences.getString('id_pelanggan') ?? '0',
      'nama': preferences.getString('nama') ?? '',
      'no_telp': preferences.getString('no_telp') ?? '',
      'email': preferences.getString('email') ?? '',
    };

    return data;
  }

  removeSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("is_login");
    preferences.remove("id_pelanggan");
  }

  setSessionAddress(double lat, double lng, String alamat, String wilayah_pengiriman) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble('latitude', lat);
    preferences.setDouble("longitude" , lng);
    preferences.setString("alamat", alamat);
    preferences.setString("wilayah_pengiriman", wilayah_pengiriman);
    preferences.setBool("hasDataAlamat", true);
  }

  getSessionAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map data = {
      'latitude': preferences.getDouble('latitude') ?? 0.0,
      'longitude': preferences.getDouble('longitude') ?? 0.0,
      'alamat': preferences.getString('alamat') ?? 'Alamat pengiriman belum dipilih',
      'wilayah_pengiriman': preferences.getString('wilayah_pengiriman') ?? 'Wilayah pengiriman belum terisi',
      'hasDataAlamat': preferences.getBool('hasDataAlamat') ?? false,
    };

    return data;
  }

  removeSessionAddress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('latitude');
    preferences.remove("longitude");
    preferences.remove("alamat");
    preferences.remove("hasDataAlamat");
  }


  setSessionPayment(String pay) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("payment", pay);
    preferences.setBool("hasDataPayment", true);
  }

  getSessionPayment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map data = {
      'payment': preferences.getString('payment') ?? 'Metode pembayaran belum dipilih',
      'hasDataPayment': preferences.getBool('hasDataPayment') ?? false,
    };

    return data;
  }

  removeSessionPayment() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("payment");
    preferences.remove("hasDataPayment");
  }

  setSessionJenisPesanan(String jenisPesanan) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("jenisPesanan", jenisPesanan);
    preferences.setBool("hasDatajenisPesanan", true);
  }

  getSessionJenisPesanan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    Map data = {
      'jenisPesanan': preferences.getString('jenisPesanan') ?? 'Jenis pesanan belum dipilih',
      'hasDatajenisPesanan': preferences.getBool('hasDatajenisPesanan') ?? false,
    };

    return data;
  }

  removeSessionJenisPesanan() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("jenisPesanan");
    preferences.remove("hasDatajenisPesanan");
  }
}