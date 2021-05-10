import 'package:covidcoffee/src/ui/main/Login.dart';
import 'package:flutter/material.dart';

class AddCartButton extends StatelessWidget {
  VoidCallback tambahKeranjang;
  VoidCallback pesanSekarang;
  bool isLogin;

  AddCartButton({
    this.tambahKeranjang,
    this.pesanSekarang,
    this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 50.0),
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(
                  color: Colors.lightBlue[800],
                )),
            child: IconButton(
              hoverColor: Colors.lightBlue[800],
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.lightBlue[800],
              ),
              onPressed: () {
                if (isLogin) {
                  tambahKeranjang();
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50.0,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                color: Colors.lightBlue[800],
                child: Text(
                  'Pesan Sekarang'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Varela',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (isLogin) {
                    pesanSekarang();
                  } else {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                          (route) => false,
                    );
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
