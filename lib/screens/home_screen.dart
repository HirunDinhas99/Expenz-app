import 'package:expenz_app/constants/colors.dart';
import 'package:expenz_app/constants/constants.dart';
import 'package:expenz_app/models/expenses_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/services/user_services.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_expence_card.dart';
import 'package:expenz_app/widgets/my_line_chart.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomeList;
  const HomeScreen(
      {super.key, required this.expensesList, required this.incomeList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "";
  double expenseTotal = 0;
  double incomeTotal = 0;
  @override
  void initState() {
    // TODO: implement initState
    UserService.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          userName = value['username']!;
        });
      }
    });
    setState(() {
      //total amount of expenses
      for (var i = 0; i < widget.expensesList.length; i++) {
        expenseTotal += widget.expensesList[i].amount;
      }

      for (var k = 0; k < widget.incomeList.length; k++) {
        incomeTotal += widget.incomeList[k].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.37,
              decoration: BoxDecoration(
                color: kMainColor.withOpacity(0.37),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(kDefalutPadding),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: kMainColor,
                            border: Border.all(
                              color: kMainColor,
                              width: 3,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              "assets/images/user.jpg",
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          "Welcome $userName",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 35),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: kMainColor,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 42),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IncomeExpenceCard(
                          title: "Income",
                          amount: incomeTotal,
                          imgUrl: "assets/images/income.png",
                          bgColor: Color(0xff00A86B),
                        ),
                        IncomeExpenceCard(
                          title: "Expenses",
                          amount: expenseTotal,
                          imgUrl: "assets/images/expense.png",
                          bgColor: Color(0xffFD3C4A),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(kDefalutPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Spend Frequency",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  LineChartSample(),
                  SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recent Transaction",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      widget.expensesList.isEmpty
                          ? Text(
                              "No Expenses You Added. Add Some Expenses",
                              style: TextStyle(
                                fontSize: 20,
                                color: kRed,
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: widget.expensesList.length,
                                        itemBuilder: (context, index) {
                                          final expense =
                                              widget.expensesList[index];
                                          return ExpenseCard(
                                            title: expense.title,
                                            amount: expense.amount,
                                            category: expense.category,
                                            date: expense.date,
                                            time: expense.time,
                                            description: expense.description,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
