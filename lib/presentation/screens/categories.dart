import 'package:books_application/presentation/screens/books_list.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Categories",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: categoriesName.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 16 / 15,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print(categoriesName[index]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BookList(name: categoriesName[index])));
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: NetworkImage(categoriesImage[index]),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3)
                          ],
                          stops: const [0.6, 0.9],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      categoriesName[index],
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

List categoriesName = [
  "Fiction",
  "Classic",
  "Romance",
  "Mystery",
  "Fantasy",
  "History",
  "Comic",
  "Crime",
];

List categoriesImage = [
  "https://arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/XRGL7V4M5VAZHKR7VDB7F6XILE.jpg",
  "https://images.unsplash.com/photo-1455885661740-29cbf08a42fa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2xhc3NpYyUyMGJvb2tzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
  "https://books.org/images/blog/romancesubgenresregency.jpg",
  "https://celadonbooks.com/wp-content/uploads/2020/03/what-is-a-mystery.jpg",
  "https://img.freepik.com/free-photo/open-book-concept-fiction-storytelling_23-2150793799.jpg?size=626&ext=jpg&ga=GA1.1.632798143.1705449600&semt=ais",
  "https://t4.ftcdn.net/jpg/02/67/83/03/360_F_267830347_XYaOxKd61vpGvHiCr8uxLhv0RFGfNI2l.jpg",
  "https://img.freepik.com/free-vector/comic-vignettes-set-with-effects-dialog-balloons_23-2147568395.jpg",
  "https://st3.depositphotos.com/1010613/18294/i/450/depositphotos_182948156-stock-photo-gavel-handcuffs-law-book-wooden.jpg",
];
