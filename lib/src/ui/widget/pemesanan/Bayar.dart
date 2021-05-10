import 'package:covidcoffee/src/utility/SessionManager.dart';
import 'package:flutter/material.dart';

class Bayar extends StatelessWidget {
  String payment;
  VoidCallback getPayment;

  Bayar({
    this.payment,
    this.getPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      margin: EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
        left: 15.0,
        right: 15.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0,),
      ),
      child: InkWell(
        onTap: () {
          showModalPembayaran(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Icon(
                Icons.payment,
                color: Colors.grey,
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Varela',
                        color: Colors.grey[800],
                        fontSize: 13.0,
                      ),
                      text: payment,
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  void showModalPembayaran(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (context, state){
              return Container(
                padding: EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  top: 10.0,
                ),
                height: 130.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       Row(
                         children: <Widget>[
                           Expanded(
                               child: Padding(
                                 padding: const EdgeInsets.only(
                                   left: 20.0,
                                   top: 10.0,
                                   bottom: 10.0,
                                 ),
                                 child: Text(
                                   "Metode Pembayaran",
                                   style: TextStyle(
                                     color: Colors.lightBlue[800],
                                     fontSize: 18.0,
                                   ),
                                 ),
                               )
                           ),
                         ],
                       ),
                    ListTile(
                      onTap: () {
                        SessionManager().setSessionPayment('Cash');
                        getPayment();
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.attach_money,
                      ),
                      trailing: payment == 'Cash' ? Icon(
                        Icons.check_box,
                        color: Colors.green[600],
                      ) : Icon(Icons.check_box_outline_blank),
                      title: Text(
                        "Cash",
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
        );
      }
    );
  }
}
