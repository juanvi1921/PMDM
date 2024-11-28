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
  String?
      _imagePath; // Variable para almacenar la ruta de la imagen seleccionada

  // Método para procesar la imagen
  Future<void> _processImage() async {
    final _picker = ImagePicker();

    try {
      // Seleccionar una imagen desde la cámara
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
      );

      if (pickedFile == null) {
        // Si el usuario no toma una foto
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
        SnackBar(content: Text('Error al tomar la foto')),
      );
    }
  }

  // Método para subir y validar la imagen
  Future<void> _uploadAndValidateImage(XFile pickedFile) async {
    // Acceder al servicio y al formulario
    final productsService =
        Provider.of<ProductsService>(context, listen: false);
    final productForm =
        Provider.of<ProductFormProvider>(context, listen: false);

    try {
      // Validar que el formulario es válido
      if (!productForm.isValidForm()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Formulario inválido. Verifica los campos.')),
        );
        return;
      }

      // Subir la imagen al servidor
      final String? imageUrl =
          await productsService.uploadImage(pickedFile.path);

      if (imageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error al subir la imagen. Intenta nuevamente.')),
        );
        return;
      }

      // Actualizar la URL de la imagen en el formulario
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
            // Mostrar la imagen actual o una URL inicial
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
            // Botón para regresar
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
            // Botón de la cámara
            Positioned(
              top: 35,
              right: 15,
              child: IconButton(
                onPressed: () async {
                  await _processImage(); // Procesar la imagen al presionar el botón
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
