import 'package:expenz_app/constants/colors.dart';
import 'package:expenz_app/models/expenses_model.dart';
import 'package:expenz_app/models/income_model.dart';
import 'package:expenz_app/screens/add_new_screen.dart';
import 'package:expenz_app/screens/budget_screen.dart';

import 'package:expenz_app/screens/home_screen.dart';
import 'package:expenz_app/screens/profile_screen.dart';
import 'package:expenz_app/screens/transaction_screen.dart';
import 'package:expenz_app/services/expense_service.dart';
import 'package:expenz_app/services/income_sevice.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  List<Expense> expenseList = [];
  List<Income> incomesList = [];
  //function fetch expenses
  void fetchAllExpenes() async {
    List<Expense> loadedExpenses = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  //fetch incomes
  void fetchAllIncomes() async {
    // Load incomes from shared preferences
    List<Income> loadedIncomes = await IncomeServices().loadIncomes();

    // Update incomesList with the fetched incomes
    setState(() {
      incomesList = loadedIncomes;
    });
  }

  // function to add new expenes
  void addNewExpense(Expense newExpenes) {
    ExpenseService().saveExpenses(newExpenes, context);

    //update Expense Lits
    setState(() {
      expenseList.add(newExpenes);
    });
  }

  void addNewIncome(Income newIncome) {
    // Save the new income to shared preferences
    IncomeServices().saveIncome(newIncome, context);

    // Update the list of incomes
    setState(() {
      incomesList.add(newIncome);
    });
  }

  //functin remove expense
  void removeExpense(Expense expense) {
    ExpenseService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }
  //functin remove Income

  void removeIncome(Income income) {
    IncomeServices().deleteIncome(income.id, context);
    setState(() {
      incomesList.remove(income);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fetchAllExpenes();
      fetchAllIncomes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Transaction(
        expensesList: expenseList,
        onDismissedExpense: removeExpense,
        incomeList: incomesList,
        onDismissedIncome: removeIncome,
      ),
      HomeScreen(),
      AddNewPage(
        addExpense: addNewExpense,
        addIcome: addNewIncome,
      ),
      BudgetPage(),
      ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_rounded,
              size: 30,
            ),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: kWhite,
                size: 35,
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.rocket,
              size: 30,
            ),
            label: "Budget",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
