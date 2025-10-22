import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:footware_admin/controller/home_controller.dart';
import 'package:footware_admin/widgets/drop_down_button.dart';
import 'package:get/get.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(title: Text('Add Product',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Product', style: TextStyle(fontSize: 30,
                    color: Colors.indigoAccent,
                    fontWeight: FontWeight.bold),),
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Product Name'),
                      hintText: 'Enter Your Product Name'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Product Description',),
                      hintText: 'Enter Your Product Description'
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: ctrl.productImgCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Image URL'),
                      hintText: 'Enter Your Image URL'
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      label: Text('Product Price'),
                      hintText: 'Enter Your Product Price'
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: DropDownBtn(
      items: const ['Boots', 'Shoes', 'High Heels'],
      SelectedItemText: ctrl.category,
      onSelected: (SelectedValue) {
      ctrl.setCategory(SelectedValue ?? 'general');
      ctrl.update();// Use setter function
      },
                      )),
                    Expanded(child: DropDownBtn(
                      items: const ['Puma', 'Adidas', 'Clarks'],
                      SelectedItemText: ctrl.brand,
                      onSelected: (SelectedValue) {
                        ctrl.setBrand(SelectedValue ?? 'un branded');
                        ctrl.update();
                      },))
                  ],
                ),
                Text('Offer Product?'),
                DropDownBtn(items: ['true', 'false'],
                  SelectedItemText: ctrl.offer.toString(),
                  onSelected: (SelectedValue) {
                  ctrl.offer= bool.tryParse(SelectedValue?? 'false')?? false;
                  ctrl.update();
                  },),
                SizedBox(height: 10,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {
                      ctrl.addProduct();
                    }, child: Text('Add Product'))

              ],
            ),
          ),
        ),
      );
    });
  }
}
