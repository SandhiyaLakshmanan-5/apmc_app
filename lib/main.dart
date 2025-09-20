import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'APMC App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginPage(),
    );
  }
}

// ===================== LOGIN PAGE =====================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _nameController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Farmer Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Farmer Name'),
                ),
                TextField(
                  controller: _pincodeController,
                  decoration: const InputDecoration(labelText: 'Pincode'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _mobileController,
                  decoration: const InputDecoration(labelText: 'Mobile No'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeDashboard(
                          farmerName: _nameController.text,
                          mobileNo: _mobileController.text,
                          pincode: _pincodeController.text,
                        ),
                      ),
                    );
                  },
                  child: const Text('Log In'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ===================== HOME DASHBOARD =====================
class HomeDashboard extends StatefulWidget {
  final String farmerName;
  final String mobileNo;
  final String pincode;

  const HomeDashboard({
    super.key,
    required this.farmerName,
    required this.mobileNo,
    required this.pincode,
  });

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      // HOME TAB:
      ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Welcome, ${widget.farmerName}',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              leading: const Icon(Icons.price_check, color: Colors.green),
              title: const Text('Market Prices / Rates for crops'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MarketPricesPage(),
                  ),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.add_shopping_cart, color: Colors.green),
              title: const Text('Add New Produce / Sell Items'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SellItemPage()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.queue, color: Colors.green),
              title: const Text('View Market Queue / Waiting Time'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WaitingTimePage(),
                  ),
                );
              },
            ),
          ),
          // NEW SETTINGS CARD inside Home:
          Card(
            child: ListTile(
              leading: const Icon(Icons.settings, color: Colors.green),
              title: const Text('Profile / Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      name: widget.farmerName,
                      mobile: widget.mobileNo,
                      pincode: widget.pincode,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // MY PRODUCE TAB:
      const SellItemPage(),

      // QUEUE TAB:
      const WaitingTimePage(),

      // SETTINGS TAB:
      SettingsPage(
        name: widget.farmerName,
        mobile: widget.mobileNo,
        pincode: widget.pincode,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('APMC App'),
        backgroundColor: Colors.green,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Sell Items',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.queue), label: 'Queue Info'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ===================== MARKET PRICES PAGE =====================
class MarketPricesPage extends StatelessWidget {
  const MarketPricesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Prices / Rates'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('🌾 Wheat - ₹2000 / quintal'))),
          Card(child: ListTile(title: Text('🍚 Rice - ₹1800 / quintal'))),
          Card(child: ListTile(title: Text('🌽 Maize - ₹1700 / quintal'))),
          Card(child: ListTile(title: Text('🥔 Potato - ₹1200 / quintal'))),
          Card(child: ListTile(title: Text('🥭 Mango - ₹50 / kg'))),
        ],
      ),
    );
  }
}

// ===================== SELL ITEM PAGE =====================
class SellItemPage extends StatefulWidget {
  const SellItemPage({super.key});

  @override
  State<SellItemPage> createState() => _SellItemPageState();
}

class _SellItemPageState extends State<SellItemPage> {
  final _productController = TextEditingController();
  final _weightController = TextEditingController();
  double? _amount;

  void _calculateAmount() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    const rate = 50; // dummy rate per kg
    setState(() {
      _amount = weight * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Produce / Sell Item'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _productController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateAmount,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Done'),
            ),
            if (_amount != null) ...[
              const SizedBox(height: 20),
              Text(
                'You can get ₹${_amount!.toStringAsFixed(2)} for ${_productController.text}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ===================== WAITING TIME PAGE =====================
class WaitingTimePage extends StatelessWidget {
  const WaitingTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    const waitingTime = '45 minutes';
    const personsAhead = 8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Queue / Waiting Time'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Estimated Waiting Time: $waitingTime',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Number of persons ahead: $personsAhead',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== SETTINGS PAGE =====================
class SettingsPage extends StatelessWidget {
  final String name;
  final String mobile;
  final String pincode;

  const SettingsPage({
    super.key,
    required this.name,
    required this.mobile,
    required this.pincode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Farmer Name: $name', style: const TextStyle(fontSize: 18)),
            Text('Mobile No: $mobile', style: const TextStyle(fontSize: 18)),
            Text('Pincode: $pincode', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: implement edit
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Edit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
