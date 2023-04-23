import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:namer_app/data/network/api_response.dart';
import 'package:provider/provider.dart';

import 'CurrencyViewModel.dart';

class CurrencyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var currency = context.watch<CurrencyViewModel>();

    if (currency.response.status == Status.ERROR) {
      return Center(
        child: Text('Can`t load data about currencies')
      );
    } else if (currency.response.status == Status.LOADING) {
      return Center(
          child: SpinKitFoldingCube(
            color: Colors.white,
            size: 50.0,
          )
      );
    }

    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text('Currency'),
        ),
        for (final cur in currency.currency.cur.entries)
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text("${cur.key} = ${cur.value} RUB"),
          ),
      ],
    );
  }
}