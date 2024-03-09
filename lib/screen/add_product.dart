import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/cubit/add_product_cubit.dart';
import 'package:fruit_market/utils/main_color.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController image = TextEditingController();
  String? selectedItem;


  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        body: BlocListener<AddProductCubit, AddProductState>(
          listener: (context, state) {
            if (state is success)
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("successful"),
                    backgroundColor: Colors.green,));
            if (state is faild)
            {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message),
                    backgroundColor: Colors.red,));
            }

          },
          child: BlocBuilder<AddProductCubit, AddProductState>(
            builder: (context, state) {
              if (state is loading)
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: name,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                color: Color(0xffCCCCCC),
                              )),
                          hintText: 'name'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: price,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                color: Color(0xffCCCCCC),
                              )),
                          hintText: 'price'),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                   border: OutlineInputBorder(
                     borderSide: BorderSide(
                       color: Colors.grey
                     ),
                     borderRadius: BorderRadius.circular(18)
                   )
                   
                  ),
                  value: selectedItem,
                  hint: Text('Select an category'),
                  onChanged: ( newValue) {
                    setState(() {
                      selectedItem = newValue;
                    });
                  },
                  items: <String>[ 'Organic Fruits', 'Mixed Fruit Pack', 'Stone Fruits']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: image,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide(
                                color: Color(0xffCCCCCC),
                              )),
                          hintText: 'path of image'),
                    ),
                    SizedBox(height: 40,),
                    ElevatedButton(onPressed: () {
                      if (
                      key.currentState!.validate()
                      ) {
                        if (name.text.isEmpty || price.text.isEmpty
                        || image.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("the Text can't be empty"),
                                backgroundColor: Colors.red,)

                          );
                        }
                        else
                          {
                            context.read<AddProductCubit>().addProduct(name, price, selectedItem!, image);
                          }
                      }
                    }, style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor
                    ),
                        child: Text('Add New Product',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white

                          ),))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
