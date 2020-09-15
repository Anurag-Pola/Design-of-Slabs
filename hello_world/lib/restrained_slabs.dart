import 'dart:math';

import 'package:flutter/material.dart';

class RestrainedSlabs extends StatefulWidget {
  @override
  _RestrainedSlabsState createState() => _RestrainedSlabsState();
}

class _RestrainedSlabsState extends State<RestrainedSlabs> {
  final _form = GlobalKey<FormState>();
  double lx;
  double ly;
  double fck;
  double fy;
  double ec;
  double ll;
  double ff;
  double dia;

  double alphanx_N;
  double alphanx_P;
  double alphany_N;
  double alphany_P;

  void solution() {
    if (_form.currentState.validate()) {
      _form.currentState.save();

      double ar = ly / lx;
      double dSR = (lx * 1000) / 26;
      double dSR2 = dSR + 20;
      double dSP2 = ((dSR2 ~/ 10) * 10).toDouble() + 10;
      double dSP = dSP2 - 20;
      print("$dSP2 $dSP");
      double sw = (dSP2 * 25) / 1000;
      double wl = sw + ff + ll;
      double ul = 1.5 * wl;

      double mux_N = alphanx_N * ul * lx * lx;
      double mux_P = alphanx_P * ul * lx * lx;
      double muy_N = alphany_N * ul * lx * lx;
      double muy_P = alphany_P * ul * lx * lx;
      double xumax_d = 0;
      print(mux_N);

      if (fy == 250) {
        xumax_d = 0.53;
      } else if (fy == 415) {
        xumax_d = 0.48;
      } else {
        xumax_d = 0.46;
      }
      double ru = 0.36 * fck * (xumax_d) * (1 - 0.42 * xumax_d);
      List<double> mu = [mux_N, mux_P, muy_N, muy_P];
      mu.sort();
      double mu_Max = mu[3];
      double dSR1 = pow((((mu_Max * pow(10, 6)) / (ru * 1000))), 0.5);
      double k1 = ((4.6 * mux_N * pow(10, 6)) / (fck * 1000 * dSP * dSP));
      double k2 = (1 - (pow((1 - k1), 0.5))) * 1000 * dSP;
      double astx_N = 0.5 * (fck / fy) * k2;
      double p1 = ((3.1416 / 4) * dia * dia / astx_N) * 1000;
      double sp1 = ((p1 ~/ 10) * 10).toDouble() - 10;
      if (sp1 > 300) {
        sp1 = 300;
      }
      double k3 = ((4.6 * mux_P * pow(10, 6)) / (fck * 1000 * dSP * dSP));
      double k4 = (1 - pow((1 - k3), 0.5)) * 1000 * dSP;
      double astx_P = 0.5 * (fck / fy) * k4;
      double p2 = ((3.1416 / 4) * dia * dia / astx_P) * 1000;
      double sp2 = ((p2 ~/ 10) * 10).toDouble() - 10;
      if (sp2 > 300) {
        sp2 = 300;
      }
      double k5 = ((4.6 * muy_N * pow(10, 6)) / (fck * 1000 * dSP * dSP));
      double k6 = (1 - pow((1 - k5), 0.5)) * 1000 * dSP;
      double asty_N = 0.5 * (fck / fy) * k6;
      double p3 = ((3.1416 / 4) * dia * dia / asty_N) * 1000;
      double sp3 = ((p3 ~/ 10) * 10).toDouble() - 10;
      if (sp3 > 300) {
        sp3 = 300;
      }
      double k7 = ((4.6 * muy_P * pow(10, 6)) / (fck * 1000 * dSP * dSP));
      double k8 = (1 - pow((1 - k7), 0.5)) * 1000 * dSP;
      double asty_P = 0.5 * (fck / fy) * k8;
      double p4 = ((3.1416 / 4) * dia * dia / asty_P) * 1000;
      double sp4 = ((p1 ~/ 10) * 10).toDouble() - 10;
      if (sp4 > 300) {
        sp4 = 300;
      }
      double ast_T = 0.75 * astx_P;
      double sm = lx / 5;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("ANSWERS"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Area of steel in X-direction (-ve) = $astx_N mm2'),
                  Divider(),
                  Text('Provide $dia mm dia bars @  $sp1 mm c/c'),
                  Divider(),
                  Text('Area of steel in X-direction (+ve) = $astx_P mm2'),
                  Divider(),
                  Text('Provide $dia mm dia bars @ $sp2 mm c/c'),
                  Divider(),
                  Text('Area of steel in Y-direction (-ve) = $asty_N mm2'),
                  Divider(),
                  Text('Provide $dia mm dia bars @ $sp3 mm c/c'),
                  Divider(),
                  Text('Area of steel in Y-direction (+ve) = $asty_P mm2'),
                  Divider(),
                  Text('Provide $dia mm dia bars @ $sp4 mm c/c'),
                  Divider(),
                  Text('Torsion Reinforcement at corners = $ast_T mm2'),
                  Divider(),
                  Text('Size of mesh at corners for Torsion Reinforcement = $sm m'),
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
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Short span of the slab in m ',
                  ),
                  onChanged: (value) {
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
                    labelText: 'Edge condition number ',
                  ),
                  onSaved: (value) {
                    ec = double.parse(value);
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
                    labelText: 'Floor finish in kN/m2 ',
                  ),
                  onSaved: (value) {
                    ff = double.parse(value);
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
                    labelText: 'Alphax(-ve) from Table 26 of IS 456:2000 ',
                  ),
                  onSaved: (value) {
                    alphanx_N = double.parse(value);
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
                    labelText: 'Alphax(+ve) from Table 26 of IS 456:2000 ',
                  ),
                  onSaved: (value) {
                    alphanx_P = double.parse(value);
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
                    labelText: 'Alphay(-ve) from Table 26 of IS 456:2000 ',
                  ),
                  onSaved: (value) {
                    alphany_N = double.parse(value);
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
                    labelText: 'Alphay(+ve) from Table 26 of IS 456:2000 ',
                  ),
                  onSaved: (value) {
                    alphany_P = double.parse(value);
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
