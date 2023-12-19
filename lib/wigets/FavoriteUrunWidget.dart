import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteUrunWidget extends StatelessWidget {
  const FavoriteUrunWidget({super.key});
  ///Bu modelde herhangi bir ek içerik eklenecek ise Product e once ekle
  /// ProductTile içerisinde ekrana gösterme işrevini gerceklesitr
  /// products listesinin içinde eklemeyi unutma
  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      // Add your products here
      Product(name: 'Steelseries Rival 3 RGB Kablolu Oyun Mouse', price: '674,00 TL',photo: "https://resim.epey.com/716042/m_xiaomi-11t-1.png",locasyon: "Manisa/Alaşehir"),
      Product(name: 'Steelseries Rival 3 RGB Kablolu Oyun Mouse', price: '674,00 TL',photo: "https://resim.epey.com/1/m_samsung-galaxy-s4-5.jpg",locasyon: "Manisa/Alaşehir"),
      Product(name: 'Steelseries Rival 3 RGB Kablolu Oyun Mouse', price: '674,00 TL',photo: "https://resim.epey.com/716503/m_apple-iphone-13-23.jpg",locasyon: "Manisa/Alaşehir"),
      // Add more products as needed
    ];
    return Padding(padding:  EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return ProductTile(product: products[index]);
                }
            )
          ],
        )

    );
  }
}
class Product {
  final String name;
  final String price;
  final String photo;
  final String locasyon;


  Product({required this.name, required this.price, required this.photo,required this.locasyon});
}
class ProductTile extends StatelessWidget {
  final Product product;
  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.antiAlias, // Card'ın köşelerine uygun olarak içeriği kırpar
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Card köşelerini yuvarlak yap
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0), // İç padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // To set a color as the background
              ),
              child: AspectRatio(
                aspectRatio: 16,
                child: Row(
                  children: [
                    Text("data"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 3,),
            Divider(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,height:15 ,),
            SizedBox(height: 3,),
            AspectRatio(
              aspectRatio: MediaQuery.of(context).size.width /200, // Resmin oranını belirleyin (genişlik/yükseklik)
              child: Image.network(
                product.photo,
                fit: BoxFit.contain, // Resmi orantılı bir şekilde kutuya sığdır
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height /80), // Resim ile metin arasında boşluk bırak
            Text(
              product.name,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height /60,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height /100), // Başlık ile alt başlık arasında boşluk bırak
            Text(
              '₺${product.price}',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height /60,
                color: Colors.grey,
              ),
            ),
            Divider(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,height:15 ,),
            SizedBox(height: MediaQuery.of(context).size.height /130), // Başlık ile alt başlık arasında boşluk bırak
            Text(
              '${product.locasyon}',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height /60,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height /100), // Alt başlık ile sepet ikonu arasında boşluk bırak
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(CupertinoIcons.delete,color: Colors.red,size: MediaQuery.of(context).size.height /30,),
                onPressed: () {
                  // Sepeten cıkartma işrevi
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


}