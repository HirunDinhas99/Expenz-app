import 'dart:convert';

import 'package:expenz_app/models/expenses_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  //expense list
  List<Expense> expensesList = [];
  //define key for storing expenses in shared preferences
  static const String _expenseKey = 'expenses';
  //save the expenses to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExepenses = prefs.getStringList(_expenseKey);

      //Convert existing Exepenses to a list of Expenses obj
      List<Expense> existingExepensesObject = [];
      if (existingExepenses != null) {
        existingExepensesObject = existingExepenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      //add new expense to list
      existingExepensesObject.add(expense);
      // Convert the list of Expense objects back to a list of strings
      List<String> updatedExpenses =
          existingExepensesObject.map((e) => json.encode(e.toJSON())).toList();

      // Save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense added successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error on adding Expenses!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //Load the expenses from shared preferences

  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExepenses = pref.getStringList(_expenseKey);
    // Convert the existing expenses to a list of Expense objects
    List<Expense> loadedExpenses = [];
    if (existingExepenses != null) {
      loadedExpenses = existingExepenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }
    return loadedExpenses;
  }
  /////////////////////////////////////////////////////////////////////////////

  //Delete the expense from shared preferences from the id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expenseKey);

      // Convert the existing expenses to a list of Expense objects
      List<Expense> existingExpenseObjects = [];
      if (existingExpenses != null) {
        existingExpenseObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // Remove the expense with the specified id from the list
      existingExpenseObjects.removeWhere((element) => element.id == id);

      // Convert the list of Expense objects back to a list of strings
      List<String> updatedExpenses =
          existingExpenseObjects.map((e) => json.encode(e.toJSON())).toList();

      // Save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show snackbar
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Expense deleted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
