import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:productos_app/widgets/get_image.dart';
import '../services/services.dart';
import '../providers/product_form_provider.dart';

class ProductImage extends StatefulWidget {
  final String? url;
  const ProductImage({super.key, this.url});

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  String? _imagePath; // Variable para almacenar la ruta de la imagen seleccionada

  Future<void> _processImage() async {
    final _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedFile == null) {
      print('No seleccionó nada');
    } else {
      print('Tenemos imagen ${pickedFile.path}');
      // Actualizar el estado con la nueva ruta de la imagen
      setState(() {
        _imagePath = pickedFile.path;
      });

      // Validar formulario y subir imagen
      await _uploadAndValidateImage();
    }
  }

  Future<void> _uploadAndValidateImage() async {
    // Acceder al ProductsService y ProductFormProvider
    final productsService = Provider.of<ProductsService>(context, listen: false);
    final productForm = Provider.of<ProductFormProvider>(context, listen: false);

    if (!productForm.isValidForm()) {
      print('Formulario inválido, no se puede subir la imagen.');
      return;
    }

    // Subir la imagen
    final String? imageUrl = await productsService.uploadImage();
    print('Image uploaded: $imageUrl');

    // Actualizar la imagen en el formulario si se subió correctamente
    if (imageUrl != null) {
      productForm.product.picture = imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                  child: getImage(_imagePath ?? widget.url), // Si no hay imagen, usa la url inicial
                ),
              ),
            ),
            Positioned(
              top: 35,
              left: 15,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
                iconSize: 40,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 35,
              right: 15,
              child: IconButton(
                onPressed: () async {
                  await _processImage(); // Procesar la imagen cuando se toma una foto
                },
                icon: const Icon(Icons.camera_alt_outlined),
                iconSize: 40,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
