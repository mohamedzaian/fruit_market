import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fruit_market/screen/cart_screen.dart';
import 'package:fruit_market/screen/favorite_screen.dart';
import 'package:fruit_market/screen/help_screen.dart';
import 'package:fruit_market/screen/login_screen.dart';
import 'package:fruit_market/utils/main_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AccountScreen extends StatefulWidget {
   AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final username = FirebaseAuth.instance.currentUser!.displayName;

  final  image = FirebaseAuth.instance.currentUser!.photoURL;

  final email = FirebaseAuth.instance.currentUser!.email;

   File? photo;
  String? imageUrl;
List <Widget> icons =
    [
      Icon(Icons.shopping_bag_rounded),
      Icon(Icons.favorite),
      Icon(Icons.settings),
      Icon(Icons.shopping_cart),
      Icon(Icons.share),
      Icon(Icons.question_mark),
      Icon(Icons.logout),

    ];
List <String> names=
    [
      'My Orders',
      'Favourites',
      'Settings',
      'My Cart',
      'Refer a Friend',
      'Help ',
      'Log Out'

    ];





  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 230,
                color: mainColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius :40,
                              child: photo == null ? null : Image.network(imageUrl!),



                            ),
                            Positioned(
                              bottom:0 ,
                              right: 0,
                              child: IconButton(onPressed: (){
                                pickImage();
                              }, icon: Icon(Icons.camera_alt_outlined),color: Colors.white,),
                            )
                          ],

                        ),

                      ),
                      SizedBox(height: 12,),
                      Text(username!,style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),),
                      SizedBox(height: 5,

                      ),
                      Text(email!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                      ),)


                    ],

                  ),
                ),
              ),

              Expanded(
                child: Container(

                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                      itemBuilder: (context,index){
                    return
                      GestureDetector(onTap: ()
                        {
                          if (index == 1)
                          {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)
                            {
                              return FavoriteScreen();
                            }));
                          }
                          if (index == 3)
                          {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)
                            {
                              return CartScreen();
                            }));

                          }
                          if (index == 6)
                          {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)
                            {
                              return LoginScreen();
                            }));

                          }
                          if (index == 5)
                            {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)
                              {
                                return HelpScreen();
                              }));
                            }
                        },
                        child: Container(
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: (
                          Row(
                          crossAxisAlignment: CrossAxisAlignment.center,

                            children: [
                              IconButton(onPressed: (){


                              }, icon: icons[index],color: mainColor,
                              iconSize: 30,),

                              Text(names[index],style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),)
                            ],
                          )
                          ),
                        ),
                                              ),
                      );

                  }, separatorBuilder: (context,index)
                      {
                        return Divider(height: 1,
                        color: Colors.black,);
                      },
                      itemCount: names.length),
                ),
              )

            ],
          ),
        ),

      );
  }
  Future pickImage ()async
  {
    final XFile? image =await ImagePicker().pickImage(source: ImageSource.camera);
    photo = File(image!.path);
    var imageName = basename(photo!.path);
    var ref = FirebaseStorage.instance.ref('Images/${imageName}');
    await ref.putFile(photo!);
    imageUrl = await ref.getDownloadURL();



    setState(() {

    });


  }



}


