import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../models/product.dart';

class EditProductScreen extends StatefulWidget {

  static const routeName = "/edit-product";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: "",
    price: 0,
    description: "",
    imageUrl: ""
  );
  var _initValues = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": ""
  };
  var _isInit = true;

  _updateImageUrl(){
    if(!_imageUrlFocusNode.hasFocus){
      if(_imageUrlController.text.isEmpty){
        return;
      }
      if(!_imageUrlController.text.startsWith("http")
          && !_imageUrlController.text.startsWith("https")){
        return;
      }
      if(
      !_imageUrlController.text.endsWith(".png")
          && !_imageUrlController.text.endsWith(".jpg")
          && !_imageUrlController.text.endsWith(".jpeg")
      ){
        return;
      }
      setState(() {}); // force rebuild to render image
    }
  }

  _saveForm(){
    final isValid = _form.currentState.validate();
    if(!isValid){
      return;
    }
    _form.currentState.save();
    if(_editedProduct.id != null){
      Provider.of<ProductsProvider>(context, listen: false).updateProduct(_editedProduct.id, _editedProduct);
    }
    else{
      Provider.of<ProductsProvider>(context, listen: false).addProduct(_editedProduct);
    }

    Navigator.of(context).pop();
  }


  @override
  void didChangeDependencies() {
    if(_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false).findById(productId).product;
        _initValues = {
          "title": _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price.toString(),
          "imageUrl": "",
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _initValues["title"],
                decoration: InputDecoration(
                  labelText: "Title"
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: value,
                      price: _editedProduct.price,
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite
                  );
                },
                validator: (value) {
                  if(value.isEmpty){
                    return "Please enter a title.";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues["price"],
                decoration: InputDecoration(
                    labelText: "Price"
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      price: double.parse(value),
                      description: _editedProduct.description,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite
                  );
                },
                validator: (value) {
                  if(value.isEmpty){
                    return "Please enter a price.";
                  }
                  if(double.tryParse(value) == null){
                    return "Please enter a valid number.";
                  }
                  if(double.parse(value) <= 0){
                    return "Please enter a price greater than \$0.";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues["description"],
                decoration: InputDecoration(
                    labelText: "Description"
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: (value){
                  _editedProduct = Product(
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      price: _editedProduct.price,
                      description: value,
                      imageUrl: _editedProduct.imageUrl,
                      isFavorite: _editedProduct.isFavorite
                  );
                },
                validator: (value) {
                  if(value.isEmpty){
                    return "Please enter a description.";
                  }
                  if(value.length < 10){
                    return "Description needs to be longer than 10 characters.";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10,),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty ? 
                    Text("Enter a URL") : 
                    FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Image URL",
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value){
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imageUrl: value,
                            isFavorite: _editedProduct.isFavorite
                        );
                      },
                      validator: (value) {
                        if(value.isEmpty){
                          return "Please enter an image URL.";
                        }
                        if(!value.startsWith("http") && !value.startsWith("https")){
                          return "Please enter a valid URL.";
                        }
                        if(
                        !value.endsWith(".png")
                            && !value.endsWith(".jpg")
                            && !value.endsWith(".jpeg")
                        ){
                          return "Please enter a valid URL.";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

















