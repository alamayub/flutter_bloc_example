import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/bloc/app_bloc.dart';
import 'package:flutter_bloc_test/bloc/app_event.dart';
import 'package:flutter_bloc_test/bloc/app_state.dart';
import 'package:flutter_bloc_test/views/main_menu_popup.dart';
import 'package:flutter_bloc_test/views/storage_image_view.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoGalleryView extends HookWidget {
  const PhotoGalleryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final images = context.watch<AppBloc>().state.images ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.gallery);
              if (image == null) {
                return;
              }
              // ignore: use_build_context_synchronously
              context.read<AppBloc>().add(
                    AppEventUploadImage(
                      filePathToUpload: image.path,
                    ),
                  );
            },
            icon: const Icon(Icons.upload),
          ),
          const MainPopupMenuButton()
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        crossAxisCount: 2,
        children: images.map((img) => StorageImageView(image: img)).toList(),
      ),
    );
  }
}
