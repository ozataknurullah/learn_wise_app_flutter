import 'package:flutter/material.dart';
import 'package:learn_wise/viewmodels/main_view_model.dart';
import 'package:learn_wise/widgets/item_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.grey),
          onPressed: () {
            // Menü açma işlemi yapılabilir
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.grey),
            onPressed: () {
              // Profil sayfasına yönlendirme yapılabilir
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                mainViewModel.filterItems(value);
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterButton('All', mainViewModel),
                _buildFilterButton('Matematik', mainViewModel),
                _buildFilterButton('Türkçe', mainViewModel),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: mainViewModel.filteredItems.length,
                itemBuilder: (context, index) {
                  final item = mainViewModel.filteredItems[index];
                  return ItemCard(
                    imageUrl: item
                        .imageUrl, // Eğer imageUrl boşsa yer tutucu gösterilecek
                    title: item.title,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String title, MainViewModel viewModel) {
    return ElevatedButton(
      onPressed: () {
        viewModel.setFilter(title);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            title == viewModel.selectedFilter ? Colors.black : Colors.grey,
      ),
      child: Text(
        title,
        style: TextStyle(
          color:
              title == viewModel.selectedFilter ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
