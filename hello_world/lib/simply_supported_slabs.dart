import 'dart:math';

import 'package:flutter/material.dart';

class SimplySupportedSlabs extends StatefulWidget {
  @override
  _SimplySupportedSlabsState createState() => _SimplySupportedSlabsState();
}

class _SimplySupportedSlabsState extends State<SimplySupportedSlabs> {
  final _form2 = GlobalKey<FormState>();

  double lx;
  double ly;
  double fck;
  double fy;
  double ll;
  double dia;
  double alphax;
  double alphay;

  void solution() {
    if (_form2.currentState.validate()) {
      _form2.currentState.save();
      print(' $lx $ly $fck $fy $ll $dia $alphax $alphay');
      double ar = ly / lx;
      double dSR = (lx * 1000) / 20;
      double dSR2 = dSR + 20;
      double dSP2 = ((dSR2 ~/ 10) * 10).toDouble() + 10;
      double dSP = dSP2 - 20;
      double sw = (dSP2 * 25) / 1000;
      double wl = sw + ll;
      double ul = 1.5 * wl;

      double mux = alphax * ul * lx * lx;
      double muy = alphay * ul * lx * lx;
      double xumax_d = 0;
      if (fy == 250) {
        xumax_d = 0.53;
      } else if (fy == 415) {
        xumax_d = 0.48;
      } else {
        xumax_d = 0.46;
      }
      double ru = 0.36 * fck * (xumax_d) * (1 - 0.42 * xumax_d);
      double mu_Max = max(mux, muy);
      double dSR1 = pow((((mu_Max * pow(10, 6)) / (ru * 1000))), 0.5);
      double k1 = ((4.6 * mux * pow(10, 6)) / (fck * 1000 * dSP * dSP));
      double k2 = (1 - (pow((1 - k1), 0.5))) * 1000 * dSP;
      double astx = 0.5 * (fck / fy) * k2;
      double p1 = ((3.1416 / 4) * dia * dia / astx) * 1000;
      double sP1 = ((p1 ~/ 10) * 10).toDouble() - 10;
      if (sP1 > 300) {
        sP1 = 300;
      }
      double k3 = ((4.6 * muy * pow(10, 6)) / (fck * 1000 * dSP * dSP));
      double k4 = (1 - pow((1 - k3), 0.5)) * 1000 * dSP;
      double asty = 0.5 * (fck / fy) * k4;
      double p3 = ((3.1416 / 4) * dia * dia / asty) * 1000;
      double sP2 = ((p3 ~/ 10) * 10).toDouble() - 10;
      if (sP2 > 300) {
        sP2 = 300;
      }
      double ast_T = 0.75 * astx;
      double sM = lx / 5;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("ANSWERS"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Area of steel in X-direction = $astx mm2'),
                  Divider(),
                  Text('Provide $dia mm dia bars @ $sP1 mm c/c'),
                  Divider(),
                  Text('Area of steel in Y-direction = $asty mm2'),
                  Divider(),
                  Text('Provide $dia mm dia bars @ $sP2 mm c/c'),
                  Divider(),
                  Text('Torsion Reinforcement at corners = $ast_T mm2'),
                  Divider(),
                  Text(
                      'Size of mesh at corners for Torsion Reinforcement = $sM m'),
                  Divider(),
                ],
              ),
            ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form2,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Short span of the slab in m ',
                  ),
                  onSaved: (value) {
                    lx = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Long span of the slab in m ',
                  ),
                  onSaved: (value) {
                    ly = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Compressive strength of concrete in N/mm2 ',
                  ),
                  onSaved: (value) {
                    fck = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Yield stress of steel in N/mm2 ',
                  ),
                  onSaved: (value) {
                    fy = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Live load in kN/m2 ',
                  ),
                  onSaved: (value) {
                    ll = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Diameter of steel bars used in mm ',
                  ),
                  onSaved: (value) {
                    dia = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Alphax from Table 26 of IS 456:2000 ',
                  ),
                  onSaved: (value) {
                    alphax = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Alphay from Table 26 of IS 456:2000 ',
                  ),
                  onSaved: (value) {
                    alphay = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please provide a value';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 140),
                  child: RaisedButton(
                    onPressed: solution,
                    color: Colors.red,
                    child: Text("Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
