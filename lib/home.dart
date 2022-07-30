import 'package:flutter/material.dart';

class Billsplitter extends StatefulWidget {
  const Billsplitter({Key? key}) : super(key: key);

  @override
  State<Billsplitter> createState() => _BillsplitterState();
}

class _BillsplitterState extends State<Billsplitter> {
  int _tippercentage = 0;
  int _personcounter = 1;
  double _billamount = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.withOpacity(0.4),
        title: Center(
            child: Text(
          "Bill Splitter",
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.greenAccent.shade100.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Per Person",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 17,
                          color: Colors.greenAccent.shade700),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Rs. ${calculateTotalPerPerson(_billamount, _personcounter, _tippercentage)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Colors.greenAccent.shade700),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              //height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.greenAccent.shade700),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billamount = double.parse(value);
                      } catch (exception) {
                        _billamount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personcounter > 1) {
                                  _personcounter--;
                                } else {}
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.greenAccent.shade100
                                      .withOpacity(0.25)),
                              child: Center(
                                  child: Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 30.0,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.greenAccent.shade700),
                              )),
                            ),
                          ),
                          Text(
                            "$_personcounter",
                            style: TextStyle(
                                color: Colors.greenAccent.shade700,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personcounter++;
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.greenAccent.shade100
                                      .withOpacity(0.25)),
                              child: Center(
                                  child: Text(
                                "+",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.greenAccent.shade700),
                              )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Text(
                          "Rs.${calculateTotalTip(_billamount, _personcounter, _tippercentage)}",
                          style: TextStyle(
                              color: Colors.greenAccent.shade700,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: [
                      Text(
                        "$_tippercentage%",
                        style: TextStyle(
                            color: Colors.greenAccent.shade700,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.greenAccent.shade200,
                          inactiveColor: Colors.grey,
                          divisions: 20,
                          value: _tippercentage.toDouble(),
                          onChanged: (double newValue) {
                            setState(() {
                              _tippercentage = newValue.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPerPerson(double billAmount, int splitBy, int tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(billAmount, splitBy, tipPercentage) + _billamount) /
            splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (_billamount < 0 ||
        billAmount.toString().isEmpty ||
        billAmount == null) {
    } else {
      totalTip = (billAmount * tipPercentage) / 100;
    }
    return totalTip;
  }
}
