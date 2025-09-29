import 'package:flutter/material.dart';
import 'package:flutter_shopping_app/l10n/app_localizations.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../widgets/hot_offer_item.dart';
import '../widgets/custom_app_bar.dart';

class ShoppingHomeScreen extends StatefulWidget {
  const ShoppingHomeScreen({super.key});

  @override
  State<ShoppingHomeScreen> createState() => _ShoppingHomeScreenState();
}

class _ShoppingHomeScreenState extends State<ShoppingHomeScreen> {
  final PageController _pageController = PageController();
  final List<Product> featuredProducts = [
    Product(
      id: '1',
      name: 'Smartphone',
      price: 699.99,
      imageUrl: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=300',
    ),
    Product(
      id: '2',
      name: 'Laptop',
      price: 999.99,
      imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300',
    ),
    Product(
      id: '3',
      name: 'Headphones',
      price: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300',
    ),
  ];
  final List<Product> products = [
    Product(
      id: '4',
      name: 'Smart Watch',
      price: 299.99,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300',
    ),
    Product(
      id: '5',
      name: 'Tablet',
      price: 449.99,
      imageUrl: 'https://images.unsplash.com/photo-1561154464-82e9adf32764?w=300',
    ),
    Product(
      id: '6',
      name: 'Camera',
      price: 799.99,
      imageUrl: 'https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?w=300',
    ),
    Product(
      id: '7',
      name: 'Gaming Mouse',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=300',
    ),
  ];
  final List<Product> hotOffers = [
    Product(
      id: '8',
      name: 'Wireless Earbuds - 50% OFF',
      price: 79.99,
      originalPrice: 159.99,
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=300',
    ),
    Product(
      id: '9',
      name: 'Smart Speaker - Limited Time',
      price: 129.99,
      originalPrice: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1543512214-318c7553f230?w=300',
    ),
    Product(
      id: '10',
      name: 'Fitness Tracker - Special Deal',
      price: 149.99,
      originalPrice: 249.99,
      imageUrl: 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=300',
    ),
    Product(
      id: '11',
      name: 'Bluetooth Keyboard - Flash Sale',
      price: 59.99,
      originalPrice: 99.99,
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=300',
    ),
    Product(
      id: '12',
      name: 'Power Bank - Bundle Offer',
      price: 39.99,
      originalPrice: 69.99,
      imageUrl: 'https://images.unsplash.com/photo-1609592393724-42c39e91cbd1?w=300',
    ),
  ];

  void _addToCart(Product product) {
    final localizations = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          localizations.itemAddedToCart,
          style: const TextStyle(fontFamily: 'Suwannaphum'),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: localizations.ourProducts,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Products Carousel
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = featuredProducts[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          Image.network(
                            product.imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  fontFamily: 'Suwannaphum',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Products Grid
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: products[index],
                    onAddToCart: () => _addToCart(products[index]),
                  );
                },
              ),
            ),
            // Hot Offers Section
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.hotOffers,
                    style: const TextStyle(
                      fontFamily: 'Suwannaphum',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: hotOffers.length,
                      itemBuilder: (context, index) {
                        return HotOfferItem(
                          product: hotOffers[index],
                          onAddToCart: () => _addToCart(hotOffers[index]),
                        );
                      },
                    ),
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