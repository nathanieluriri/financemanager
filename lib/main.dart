import 'package:financemanager/Api/Auth/CreateUser.dart';
import 'package:financemanager/Api/Auth/LoginUser.dart';
import 'package:financemanager/Api/Budget/CreateBudget.dart';
import 'package:financemanager/Api/Budget/GetAllBudgets.dart';
import 'package:financemanager/Api/Categories/GetAllCategories.dart';
import 'package:financemanager/Api/CreateTransaction/CreateExpense.dart';
import 'package:financemanager/Api/CreateTransaction/CreateIncome.dart';
import 'package:financemanager/Api/GetTransactions/Balance.dart';
import 'package:financemanager/Api/GetTransactions/Expense.dart';
import 'package:financemanager/Api/GetTransactions/Income.dart';
import 'package:financemanager/Api/GetTransactions/TransactionList.dart';
import 'package:financemanager/Api/Goals/CreateGoal.dart';
import 'package:financemanager/Api/Goals/GetAllGoals.dart';
import 'package:financemanager/Api/Goals/GetGoalStats.dart';
import 'package:financemanager/Api/ReportAndAnalysis/GetCategorizedExpense.dart';
import 'package:financemanager/Api/ReportAndAnalysis/GetCategorizedIncome.dart';
import 'package:financemanager/Api/connection.dart';
import 'package:financemanager/LoggedInUserFLow/BudgetingAndMonitoring/PlanABudget.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/ExpenseTrackingPage.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/IncomeTrackingPage.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/MoneyPlaning/Planing.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/ReportAndAnalytics/MainReportPage.dart';
import 'package:financemanager/LoggedInUserFLow/FinancialGoal/FinancialGoal.dart';
import 'package:financemanager/LoggedInUserFLow/FinancialGoal/SetupANewGoalPage.dart';
import 'package:financemanager/LoggedInUserFLow/GoalsAndBudget/TabsForGoalsAndBudget.dart';
import 'package:financemanager/LoggedInUserFLow/Overview/Overview.dart';
import 'package:financemanager/LoginScreen.dart';
import 'package:financemanager/createAccountFlow/PasswordRecoveryPage.dart';
import 'package:financemanager/createAccountFlow/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';

void main() async {
  await Hive.initFlutter();
  Box Authbox = await Hive.openBox("AuthInformation");
  Box userbox = await Hive.openBox("UserInformation");
  Authbox.put("App Bar Has Network Count", 0);
  userbox.put(
      "Is Overview Loading", (userbox.get("Is Overview Loading") ?? 0) + 1);
  Authbox.put(
      "Is Overview Loading", (Authbox.get("Is Overview Loading") ?? 0) + 1);

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Timer _AppBartimer;
  late Timer _balanceTimer;
  late Timer _categoriesTimer;
  late Timer _budgetTimer;
  late Timer _goalTimer;
  late Timer _reportTimer;
  bool appBarshouldShow = true;
  bool hasNetwork = true;
  Box Authbox = Hive.box("AuthInformation");
  Box userbox = Hive.box("UserInformation");
  int hasNetworkCount = 1;
  final PageController _pageController = PageController();
  late List<Widget> views;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _AppBartimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _checkNetworkStatus();
    });
    _balanceTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _checkExpense();
    });
    _categoriesTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _checkCategories();
    });
    _budgetTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _checkBudgets();
    });
    _goalTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _checkGoals();
    });
    _reportTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      _makeDataAnalysis();
    });
    views = [
      LoginScreen(
        //0
        loginButton: () async {
          bool loggedIn = await loginUser(
              email: Authbox.get("Login Email") ?? '',
              password: Authbox.get("Login Password") ?? '',
              userdb: userbox);
          if (loggedIn) {
            animateToPage(3);
          }
        },
        signUpButton: () {
          animateToPage(1);
        },
        forgottenPassword: () {
          jumpToPage(2);
        },
        userdb: Authbox,
      ),
      Signuppage(
        //1
        signUpButton: () async {
          bool registered = await registerUser(
              firstName: Authbox.get("First Name"),
              secondName: Authbox.get("Second Name"),
              email: Authbox.get("Email"),
              password: Authbox.get("Password"),
              userdb: userbox);
          if (registered) {
            jumpToPage(3);
          }
        },
        backButton: () {
          animateToPage(0);
        },
        userbox: Authbox,
      ),
      PasswordRecoveryPage(
        //2
        backButton: () {
          jumpToPage(0);
        },
      ),
      Overview(
          //3
          accountDetails: userbox,
          moveToReportPage: () {
            jumpToPage(8);
          },
          moveToGoalPage: () {
            jumpToPage(5);
          },
          floatingActionButton: () {
            animateToPage(4);
          }),
      MoneyplanningPage(
        //4
        backButton: () {
          animateToPage(3);
        },
        userBox: userbox,
        incomePlanButton: () async {
          dynamic response = await createIncomeTransaction(
              bearerToken: '${userbox.get("Token")}',
              name: userbox.get("Transaction Name"),
              amount: int.parse(userbox
                  .get("Transaction Amount")
                  .toString()
                  .replaceAll(RegExp(r','), '')),
              categoryId: userbox.get("Selected Category Id"));
          if (response['status_code'] == 201) {
            animateToPage(3);
          }
        },
        expensePlanButton: () async {
          dynamic response = await createExpenseTransaction(
              bearerToken: '${userbox.get("Token")}',
              name: userbox.get("Transaction Name"),
              amount: int.parse(userbox
                  .get("Transaction Amount")
                  .toString()
                  .replaceAll(RegExp(r','), '')),
              categoryId: userbox.get("Selected Category Id"));
          if (response['status_code'] == 201) {
            animateToPage(3);
          }
        },
      ),
      MainPageForGoalsAndBudget(
        //5
        moveToReportPage: () {
          jumpToPage(8);
        },
        moveToOverviewPage: () {
          jumpToPage(3);
        },
        userBox: userbox,
        setupBudgetButton: () {
          jumpToPage(7);
        },
        setupGoalButton: () {
          animateToPage(6);
        },
        editGoalButton: () {},
      ),
      SetupANewGoalPage(
          userbox: userbox,
          planANewGoalButon: () async {
            dynamic response = await createGoal(
                name: userbox.get("Goal Name"),
                requiredAmount: int.parse(userbox
                    .get("Goal Required Amount")
                    .replaceAll(RegExp(r','), '')),
                accumulatedAmount: int.parse(userbox
                    .get("Goal Accumulated Amount")
                    .replaceAll(RegExp(r','), '')),
                bearerToken: userbox.get("Token"));
            if (response == 201) {
              animateToPage(5);
            }
          },
          backButton: () {
            animateToPage(5);
          }), //6
      PlanABudget(
          userBox: userbox,
          planABudgetButton: () async {
            dynamic response = await createBudget(
                budgetName: "Monthly Budget",
                totalIncome: int.parse(userbox
                    .get("Budget Expected Income")
                    .replaceAll(RegExp(r','), '')),
                bearerToken: userbox.get("Token"));

            if (response['status_code'] == 201) {
              animateToPage(5);
            }
          },
          backButton: () {
            animateToPage(5);
          }), //7
      ReportAndAnalyticsPage(
          moveToOverviewPage: () {
            jumpToPage(3);
          },
          userBox: userbox,
          moveToGoalPage: () {
            jumpToPage(5);
          })
    ];
  }

  void _checkCategories() async {
    if (await connectionStatus()) {
      final result = await fetchCategories(userbox.get("Token"));
      if (result['status_code'] == 200) {
        final incomeCategories = result['categories']
            .where((category) => category['category_type'] == 'income')
            .toList();
        final expenseCategories = result['categories']
            .where((category) => category['category_type'] == 'expense')
            .toList();
        userbox.put("Income Categories", incomeCategories);
        userbox.put("Expense Categories", expenseCategories);
      }
    }
  }

  void _checkBudgets() async {
    if (await connectionStatus()) {
      final result = await fetchBudgets(userbox.get("Token"));
      if (result['status_code'] == 200) {
        userbox.put("Budget", result['data']['budgets']);
        userbox.put(
            "Total Spent",
            (result['data']?['budgets']?['needs_spent_amount'] ?? 0) +
                (result['data']?['budgets']?['wants_spent_amount'] ?? 0));
      }
    }
  }

  void _checkGoals() async {
    if (await connectionStatus()) {
      final result = await fetchGoals(userbox.get("Token"));
      final resultStats = await fetchGoalStats(userbox.get("Token"));
      if (result['status_code'] == 200) {
        userbox.put("Goals", result['data']);

        int totalSavings = 0;
        for (dynamic data in result['data']) {
          int amount = data['accumulated_amount'];
          totalSavings += amount;
        }
        userbox.put("Total Savings", totalSavings);
      }

      if (resultStats['status_code'] == 200) {
        userbox.put("Goals Statistics", resultStats['goalsStats']);
      }
    }
  }

  void animateToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500), // Animation duration
      curve: Curves.easeInOut, // Animation curve
    );
  }

  void _makeDataAnalysis() async {
    dynamic response = await fetchCategorizedIncome(userbox.get("Token"));
    dynamic response2 = await fetchCategorizedExpense(userbox.get("Token"));
    if (await connectionStatus()) {
      if (response2['status_code'] == 200) {
        userbox.put("Categorized Expense List",
            response2['data']?['categorize_expense']?['categories']);
      }
      if (response['status_code'] == 200) {
        userbox.put("Categorized Income List",
            response['data']?['categorize_income']?['categories']);
      }
    }
  }

  void jumpToPage(int index) {
    _pageController.jumpToPage(
      index,
      // Animation curve
    );
  }

  void _checkExpense() async {
    if (await connectionStatus()) {
      dynamic balanceinfo = await fetchBalance("${userbox.get("Token")}");
      dynamic totalIncome = await fetchIncome("${userbox.get("Token")}");
      dynamic totalExpense = await fetchExpense("${userbox.get("Token")}");
      dynamic transactions = await fetchTransactions("${userbox.get("Token")}");

      if (balanceinfo['success'] &&
          totalExpense['success'] &&
          totalIncome['success'] &&
          transactions['status_code'] == 200) {
        userbox.put("balance", balanceinfo['balance']);
        userbox.put("totalIncome", totalIncome['balance']);
        userbox.put("totalExpense", totalExpense['balance']);
        userbox.put("transactions", transactions['data']['transactions']);
      } else {
        // print(userbox.get("Balance"));
        // print(userbox.get("Token"));
        // print(userbox.get("First Name"));
      }
    }
  }

  void _checkNetworkStatus() async {
    if (await connectionStatus()) {
      if (mounted) {
        setState(() {
          appBarshouldShow = true;

          Authbox.put("Has Network", true);
          Authbox.put("App Bar Has Network Count",
              Authbox.get("App Bar Has Network Count") + 1);
        });
        if (Authbox.get("Has Network") == true &&
            Authbox.get("App Bar Has Network Count") >= 5) {
          if (mounted) {
            setState(() {
              appBarshouldShow = false;
            });
          }
        }
      }
    } else {
      if (mounted) {
        setState(() {
          appBarshouldShow = true;
          Authbox.put("Has Network", false);
          Authbox.put("App Bar Has Network Count", 0);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Authbox.get("Has Network") == false
            ? Colors.deepOrange
            : Colors.transparent,
        body: SafeArea(
          child: appBarshouldShow
              ? Scaffold(
                  backgroundColor: Colors.white,
                  appBar: Authbox.get("Has Network") == true
                      ? PreferredSize(
                          preferredSize:
                              Size.fromHeight(30.0), // Set custom height here
                          child: AppBar(
                            title: Text(
                              'Online',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            backgroundColor: Colors.green.shade100,
                            centerTitle: true,
                            leading: Icon(
                              Icons.wifi,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      : PreferredSize(
                          preferredSize:
                              Size.fromHeight(30.0), // Set custom height here
                          child: AppBar(
                            title: Text(
                              'Offline',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade400,
                            centerTitle: true,
                            leading: Icon(
                              Icons.wifi_off,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                  body: PageView(
                    children: views,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                )
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: views,
                  ),
                ),
        ),
      ),
    );
  }
}
