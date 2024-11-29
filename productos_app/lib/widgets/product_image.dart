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
  String? _imagePath;

  // Método para procesar la imagen (desde cámara o galería)
  Future<void> _processImage(ImageSource source) async {
    final _picker = ImagePicker();

    try {
      // Seleccionar una imagen desde la fuente especificada
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );

      if (pickedFile == null) {
        // Si el usuario no selecciona una imagen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se seleccionó ninguna imagen')),
        );
        return;
      }

      // Actualizar la variable local de la imagen
      setState(() {
        _imagePath = pickedFile.path;
      });

      // Actualizar la imagen seleccionada en el servicio
      final productsService =
          Provider.of<ProductsService>(context, listen: false);
      productsService.updateSelectedProductImage(pickedFile.path);

      // Validar y subir la imagen
      await _uploadAndValidateImage(pickedFile);
    } catch (e) {
      print('Error al procesar la imagen: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar la imagen')),
      );
    }
  }

  Future<void> _uploadAndValidateImage(XFile pickedFile) async {
    final productsService =
        Provider.of<ProductsService>(context, listen: false);
    final productForm =
        Provider.of<ProductFormProvider>(context, listen: false);

    try {
      if (!productForm.isValidForm()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Formulario inválido. Verifica los campos.')),
        );
        return;
      }

      final String? imageUrl =
          await productsService.uploadImage(pickedFile.path);

      if (imageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error al subir la imagen. Intenta nuevamente.')),
        );
        return;
      }

      setState(() {
        productForm.product.picture = imageUrl;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Imagen actualizada con éxito')),
      );
    } catch (e) {
      print('Error al subir o validar la imagen: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ocurrió un error al subir la imagen')),
      );
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
                  child: getImage(_imagePath ?? widget.url),
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
              right: 75, // Ajuste para dejar espacio al botón de galería
              child: IconButton(
                onPressed: () async {
                  await _processImage(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt_outlined),
                iconSize: 40,
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 35,
              right: 15,
              child: IconButton(
                onPressed: () async {
                  await _processImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo_library_outlined),
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
