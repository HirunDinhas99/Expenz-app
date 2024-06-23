import 'package:expenz_app/constants/colors.dart';
import 'package:expenz_app/constants/constants.dart';
import 'package:expenz_app/models/expenses_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/widgets/expense_card.dart';
import 'package:expenz_app/widgets/income_card.dart';
import 'package:flutter/material.dart';

class Transaction extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomeList;
  final void Function(Expense) onDismissedExpense;
  final void Function(Income) onDismissedIncome;
  const Transaction({
    super.key,
    required this.expensesList,
    required this.onDismissedExpense,
    required this.incomeList,
    required this.onDismissedIncome,
  });

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "See your financial report",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: kMainColor,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Expenses",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                ),
                SizedBox(height: 20),
                //show all expenses
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.expensesList.length,
                            itemBuilder: (context, index) {
                              final expense = widget.expensesList[index];
                              return Dismissible(
                                key: ValueKey(expense),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  setState(() {
                                    widget.onDismissedExpense(expense);
                                  });
                                },
                                child: ExpenseCard(
                                  title: expense.title,
                                  amount: expense.amount,
                                  category: expense.category,
                                  date: expense.date,
                                  time: expense.time,
                                  description: expense.description,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Income",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kBlack,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.incomeList.length,
                            itemBuilder: (context, index) {
                              final income = widget.incomeList[index];
                              return Dismissible(
                                key: ValueKey(income),
                                direction: DismissDirection.startToEnd,
                                onDismissed: (direction) {
                                  setState(() {
                                    widget.onDismissedIncome(income);
                                  });
                                },
                                child: IncomeCard(
                                  title: income.title,
                                  amount: income.amount,
                                  category: income.category,
                                  date: income.date,
                                  time: income.time,
                                  description: income.description,
                                ),
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
          ),
        ),
      ),
    );
  }
}
