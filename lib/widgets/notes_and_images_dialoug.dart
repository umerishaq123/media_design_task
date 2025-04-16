import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:media_desgin_expert_task/controllers/images_notes_controller.dart';
import 'package:media_desgin_expert_task/controllers/order_provider.dart';
import 'package:media_desgin_expert_task/models/product_model.dart';
import 'package:media_desgin_expert_task/utilis/colors.dart';
import 'package:provider/provider.dart';

class NotesAndImagesDialog extends StatefulWidget {
  final int productIndex;
  final ProductModel product;

  const NotesAndImagesDialog({
    Key? key,
    required this.productIndex,
    required this.product,
  }) : super(key: key);

  @override
  _NotesAndImagesDialogState createState() => _NotesAndImagesDialogState();
}

class _NotesAndImagesDialogState extends State<NotesAndImagesDialog> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ImagesNotesController>(context, listen: false);
      provider.reset();
    provider.initializeNotes(widget.product.notes);
    if (widget.product.imagePath != null) {
      provider.setImagePath(widget.product.imagePath); 
    }
  }

  void _saveChanges(BuildContext context) {
    final notesProvider = Provider.of<ImagesNotesController>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    
    // Update notes if changed
    if (notesProvider.notesController.text != widget.product.notes) {
      orderProvider.updateProductNotes(
        widget.productIndex, 
        notesProvider.notesController.text
      );
    }
    
    // Update image if changed
    if (notesProvider.imagePath != widget.product.imagePath) {
      if (notesProvider.imagePath != null) {
        orderProvider.updateProductImage(
          widget.productIndex, 
          notesProvider.imagePath!
        );
      } else {
        orderProvider.clearProductImage(widget.productIndex);
      }
    }
    
    Navigator.of(context).pop();
  }
  
  @override
  void dispose() {
    // Reset the controller when dialog is disposed
    Provider.of<ImagesNotesController>(context, listen: false).reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: whiteColor,
      title: Text('Notes & Images for ${widget.product.name}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<ImagesNotesController>(
              builder: (context, provider, child) {
                return TextField(
                  controller: provider.notesController,
                  decoration: InputDecoration(
                    labelText: 'Notes',
                    border: OutlineInputBorder(),
                    hintText: 'Add any special instructions...',
                  ),
                  maxLines: 5,
                  minLines: 3,
                );
              },
            ),
            const SizedBox(height: 20),
            Consumer<ImagesNotesController>(
              builder: (context, provider, child) {
                if (provider.isImageLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.imagePath != null) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 200,
                      maxWidth: MediaQuery.of(context).size.width * 0.8,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        File(provider.imagePath!),
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Text(
                                'Failed to load image',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Consumer<ImagesNotesController>(
                  builder: (context, provider, child) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                      onPressed: provider.isImageLoading 
                          ? null 
                          : () => provider.pickImage(context),
                    );
                  },
                ),
                Consumer<ImagesNotesController>(
                  builder: (context, provider, child) {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Camera'),
                      onPressed: provider.isImageLoading
                          ? null
                          : () => provider.takePhoto(context),
                    );
                  },
                ),
              ],
            ),
            Consumer<ImagesNotesController>(
              builder: (context, provider, child) {
                if (provider.imagePath != null && !provider.isImageLoading) {
                  return TextButton(
                    onPressed: provider.clearImage,
                    child: const Text(
                      'Remove Image', 
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => _saveChanges(context),
          child: Text(
            'Save Changes',
            style: GoogleFonts.publicSans(
              fontWeight: FontWeight.w500,
              color: whiteColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}