import 'package:flutter/material.dart';

class ListViewSeperate extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final int lenght;
  const ListViewSeperate({super.key, required this.image, required this.name, required this.price, required this.lenght});


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)
        {
          return  Container(
            height: 220,
            width: 118,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                        height: 143,
                        width: 118,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: NetworkImage(
                                    image),
                                fit: BoxFit.fill
                            )

                        )
                    ),
                    Positioned(
                      top: 5,
                      right: 9,
                      child: CircleAvatar(radius: 20,
                          child: IconButton(onPressed: () {

                          }, icon: Icon(Icons.favorite_border),)),
                    )
                  ],
                ),
                SizedBox(height: 15,),
                Text(name, style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                ),),
                SizedBox(height: 6,),
                Text(price, style: TextStyle(
                    fontSize: 12,
                    color: Colors.black
                ),),


              ],

            ),

          );
        },
        separatorBuilder: (context,index)
        {
          return SizedBox(width: 20,);
        },
        itemCount: lenght);;
  }
}
