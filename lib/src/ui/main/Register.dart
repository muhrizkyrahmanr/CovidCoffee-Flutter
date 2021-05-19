import 'package:covidcoffee/src/bloc/AuthBloc.dart';
import 'package:covidcoffee/src/ui/main/Login.dart';
import 'package:covidcoffee/src/ui/main/MainNavigation.dart';
import 'package:covidcoffee/src/utility/SessionManager.dart';
import 'package:covidcoffee/src/utility/ShowToast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  String loadPage;

  Register({
    this.loadPage
  });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController _konfirmasipasswordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _notelpController = TextEditingController();

  bool isRegister = false;
  bool isValidEmail = false;
  bool isValidPassword = false;
  bool isValidKonfirmasiPassword = false;
  bool isValidKonfirmasiPasswordInput = false;
  bool isValidNama = false;
  bool isValidNoTelp = false;
  String isValidEmailText = 'email harus diisi.';
  String isValidPasswordText = 'password harus diisi.';
  String isValidKonfirmasiPasswordText = 'konfirmasi password harus diisi.';
  String isValidNamaText = 'nama harus diisi.';
  String isValidNoTelpText = 'no. telepon harus diisi.';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Login()), (route) => false);
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return Container(
                  height: MediaQuery.of(context).size.height + 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage('assets/img/bg.jpg'),
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.05),
                          BlendMode.dstATop,
                        ),
                        fit: BoxFit.cover,
                      )),
                  child: Column(
                    children: [
                      getTitle(),
                      getNama(state),
                      getNoTelp(state),
                      getEmail(state),
                      getPassword(state),
                      new Visibility(
                          visible: isValidKonfirmasiPasswordInput == true ? true : false,
                          child:  getKonfirmasiPassword(state)
                      ),
                      getButtonRegister(state),
                      getLogin(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget getTitle() {
    return Container(
      padding: EdgeInsets.only(
        top: 30.0,
        bottom: 30.0,
      ),
      child: Column(
        children: [
          Text(
            'Daftar Pelanggan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
          ),
          Text(
            'Silahkan isi form pendaftaran dibawah ini.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.0,
            ),
          ),
        ],
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

  Widget getButtonRegister(state) {
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
                  color: !isValidEmail || !isValidPassword || !isValidNama || !isValidNoTelp || !isValidKonfirmasiPassword
                      ? Colors.lightBlue[800].withOpacity(0.5)
                      : Colors.lightBlue[800],
                  onPressed: () {
                    if (isValidEmail && isValidPassword && isValidNama && isValidNoTelp && isValidKonfirmasiPassword) {
                      _Register();
                    } else {
                      validateEmail(state);
                      validatePassword(state);
                      validateKonfirmasiPassword(state);
                      validateNama(state);
                      validateNoTelp(state);
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
                        isRegister
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
                                  'Daftar',
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
          height: 24.0,
        )
      ],
    );
  }

  Widget getLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Sudah punya akun? ',
          style: TextStyle(
            fontFamily: 'Varela',
            fontWeight: FontWeight.w400,
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              builder: (context) => Login()
            ), (route) => false);
          },
          child: Text(
            'Login',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.lightBlue[800],
              fontSize: 14.0,
            ),
          ),
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
        isValidPasswordText = 'password harus diisi.';
      });
    } else {
      updateState(() {
        isValidPassword = false;
        isValidKonfirmasiPasswordInput = false;
        isValidPasswordText = 'minimal 6 karakter!';
      });
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

  _Register() async {
    setState(() {
      isRegister = true;
    });

    final res = await authBloc.registrasi(
      _emailController.text,
      _passwordController.text,
      _namaController.text,
      _notelpController.text,
    );

    bool status = res['status'];
    String message = res['message'];

    if (status) {
      print(message);

      setState(() {
        isRegister = false;
      });

      SessionManager().setSession(res['data']['id'].toString(),res['data']['nama'],res['data']['no_telp'],res['data']['email']);
      if(widget.loadPage == "Transaksi" || widget.loadPage == "Akun"){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => MainNavigation(
            loadPage: widget.loadPage,
            id_pelanggan: res['data']['id'].toString(),
          ),
        ), (route) => false);
      }else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => MainNavigation(),
        ), (route) => false);
      }
    } else {
      print(message);

      setState(() {
        isRegister = false;
      });

      Fluttertoast.showToast(msg:message);
    }
  }
}
