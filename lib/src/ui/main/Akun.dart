import 'package:covidcoffee/src/bloc/AuthBloc.dart';
import 'package:covidcoffee/src/ui/widget/Akun/AppBar.dart';
import 'package:covidcoffee/src/utility/SessionManager.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Login.dart';
import 'MainNavigation.dart';

class Akun extends StatefulWidget {

  @override
  _AkunState createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  String id_pelanggan;

  TextEditingController _namaController;
  TextEditingController _emailController;
  TextEditingController _notelpController;
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController _konfirmasipasswordController = TextEditingController();

  bool isEdit = false;
  bool isValidEmail = true;
  bool isValidPassword = false;
  bool isValidKonfirmasiPassword = false;
  bool isValidKonfirmasiPasswordInput = false;
  bool isValidNama = true;
  bool isValidNoTelp = true;
  String isValidEmailText = 'email harus diisi.';
  String isValidPasswordText = 'isi jika ingin mengubah password.';
  String isValidKonfirmasiPasswordText = 'konfirmasi password harus diisi.';
  String isValidNamaText = 'nama harus diisi.';
  String isValidNoTelpText = 'no. telepon harus diisi.';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter state) {
              return Container(
                margin: EdgeInsets.only(
                  top: 24.0,
                ),
                child: Column(
                  children: [
                    getNama(state),
                    getNoTelp(state),
                    getEmail(state),
                    getPassword(state),
                    new Visibility(
                          visible: isValidKonfirmasiPasswordInput == true ? true : false,
                          child:  getKonfirmasiPassword(state)
                    ),
                    getButtonUpdate(state),
                    getButtonLogout(state),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getNama(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Nama',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 0.0,
            right: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _namaController,
                  autofocus: false,
                  onChanged: (text) {
                    validateNama(state);
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'masukkan nama anda',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  maxLengthEnforced: true,
                  validator: (value) {
                    return !isValidNama ? isValidNamaText : null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  Widget getNoTelp(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'No. Telp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 0.0,
            right: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _notelpController,
                  autofocus: false,
                  onChanged: (text) {
                    validateNoTelp(state);
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(
                        12.0,
                      ),
                      child: Text(
                        '+62',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    hintText: 'masukkan no. telepon anda',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  maxLengthEnforced: true,
                  validator: (value) {
                    return !isValidNoTelp ? isValidNoTelpText : null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  Widget getEmail(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Email',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 0.0,
            right: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  enabled: false,
                  keyboardType: TextInputType.text,
                  controller: _emailController,
                  autofocus: false,
                  onChanged: (text) {
                    validateEmail(state);
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'masukkan email anda',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  maxLengthEnforced: true,
                  validator: (value) {
                    return !isValidEmail ? isValidEmailText : null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  Widget getPassword(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 0.0,
            right: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _passwordController,
                  autofocus: false,
                  onChanged: (text) {
                    validatePassword(state);
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'masukkan password anda',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  maxLengthEnforced: true,
                  obscureText: true,
                  validator: (value) {
                    return !isValidPassword ? isValidPasswordText : null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  Widget getKonfirmasiPassword(state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  'Konfirmasi Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                    fontSize: 15.0,
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.only(
            left: 0.0,
            right: 10.0,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _konfirmasipasswordController,
                  autofocus: false,
                  onChanged: (text) {
                    validateKonfirmasiPassword(state);
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    hintText: 'masukkan ulang password anda',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  autovalidate: true,
                  autocorrect: false,
                  maxLengthEnforced: true,
                  obscureText: true,
                  validator: (value) {
                    return !isValidKonfirmasiPassword ? isValidKonfirmasiPasswordText : null;
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  Widget getButtonUpdate(state) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
            top: 24.0,
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                  color: _passwordController.text == "" ?
                            !isValidEmail || !isValidNama || !isValidNoTelp ?
                                Colors.lightBlue[800].withOpacity(0.5)
                            : Colors.lightBlue[800]
                          : !isValidEmail || !isValidNama || !isValidNoTelp || !isValidPassword || !isValidKonfirmasiPassword ?
                              Colors.lightBlue[800].withOpacity(0.5)
                            : Colors.lightBlue[800],
                  onPressed: () {
                    if(_passwordController.text != ""){
                      if (isValidEmail && isValidNama && isValidNoTelp && isValidPassword && isValidKonfirmasiPassword) {
                        _Edit();
                      } else {
                        validateEmail(state);
                        validateNama(state);
                        validateNoTelp(state);
                        validateKonfirmasiPassword(state);
                      }
                    } else {
                      if (isValidEmail && isValidNama && isValidNoTelp) {
                        _Edit();
                      } else {
                        validateEmail(state);
                        validateNama(state);
                        validateNoTelp(state);
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        isEdit
                            ? Container(
                          height: 16.0,
                          width: 16.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2.0,
                          ),
                        )
                            : Expanded(
                          child: Text(
                            'Simpan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }

  Widget getButtonLogout(state) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              Expanded(
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30.0,
                    ),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    SessionManager().removeSession();
                    SessionManager().removeSessionAddress();
                    SessionManager().removeSessionPayment();
                    SessionManager().removeSessionJenisPesanan();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) => MainNavigation(),
                    ), (route) => false);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 24.0,
        )
      ],
    );
  }

  validateEmail(StateSetter updateState) async {
    if (!EmailValidator.validate(_emailController.text)) {
      updateState(() {
        isValidEmailText = 'email tidak valid!';
        isValidEmail = false;
      });
    } else {
      updateState(() {
        isValidEmail = true;
      });
    }
  }

  validatePassword(StateSetter updateState) async {
    _konfirmasipasswordController = TextEditingController();
    isValidKonfirmasiPassword = false;
    isValidKonfirmasiPasswordText = 'konfirmasi password harus diisi.';
    if (_passwordController.text.length >= 6) {
      updateState(() {
        isValidPassword = true;
        isValidKonfirmasiPasswordInput = true;
      });
    } else if(_passwordController.text == ""){
      updateState(() {
        isValidPassword = false;
        isValidKonfirmasiPasswordInput = false;
        isValidPasswordText = 'isi jika ingin mengubah password.';
      });
    } else {
      updateState(() {
        isValidPassword = false;
        isValidKonfirmasiPasswordInput = false;
        isValidPasswordText = 'minimal 6 karakter!';
      });
    }
  }

  validateKonfirmasiPassword(StateSetter updateState) async {
    if (isValidPassword == true) {
      if(_passwordController.text.toString() == _konfirmasipasswordController.text.toString()){
        updateState(() {
          isValidKonfirmasiPassword = true;
        });
      }else if(_konfirmasipasswordController.text == ""){
        updateState(() {
          isValidKonfirmasiPassword = false;
          isValidKonfirmasiPasswordText = 'konfirmasi password harus diisi.';
        });
      }else {
        updateState(() {
          isValidKonfirmasiPassword = false;
          isValidKonfirmasiPasswordText = 'konfirmasi password tidak sama dengan password.';
        });
      }
    }
  }

  validateNama(StateSetter updateState) async {
    if (_namaController.text != '') {
      updateState(() {
        isValidNama = true;
      });
    } else {
      updateState(() {
        isValidNama = false;
      });
    }
  }

  validateNoTelp(StateSetter updateState) async {
    if (_notelpController.text.length >= 10) {
      updateState(() {
        isValidNoTelp = true;
      });
    } else if (_notelpController.text.length <= 10) {
      updateState(() {
        isValidNoTelp = false;
        isValidNoTelpText = 'minimal 10 angka!';
      });
    }
  }

  _Edit() async {
    setState(() {
      isEdit = true;
    });

    final res = await authBloc.editPelanggan(
       id_pelanggan,
      _namaController.text,
      _notelpController.text,
      _passwordController.text,
    );

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      setState(() {
        isEdit = false;
      });
      SessionManager().setSession(id_pelanggan,_namaController.text,_notelpController.text,_emailController.text);
      Fluttertoast.showToast(msg:message);

    } else {
      setState(() {
        isEdit = false;
      });

      Fluttertoast.showToast(msg:message);
    }
  }

  _getInfo() async {
    Map _result = await SessionManager().getInfoPelanggan();

    setState(() {
      id_pelanggan = _result['id_pelanggan'];
      _namaController = TextEditingController(text: _result['nama']);
      _emailController = TextEditingController(text: _result['email']);
      _notelpController = TextEditingController(text: _result['no_telp']);
    });
  }
}
