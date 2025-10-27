import 'dart:io';
import 'package:flutter/material.dart';
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_bloc.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_event.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_state.dart';
import 'package:groovix/features/shared/playlist/domain/models/user_playlist_params.dart';
import 'package:groovix/features/cms/songs/presentation/widgets/file_picker.dart';
import 'package:groovix/features/cms/shared/widgets/loading_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:groovix/injection_container/injection_initializer.dart';

class CMSAddPlaylistScreen extends StatefulWidget {
  const CMSAddPlaylistScreen({super.key});

  @override
  State<CMSAddPlaylistScreen> createState() => _CMSAddPlaylistScreenState();
}

class _CMSAddPlaylistScreenState extends State<CMSAddPlaylistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _playlistNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  File? _selectedCoverFile;
  bool _isPublic = true;

  @override
  void dispose() {
    _playlistNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _pickCoverFromStorage() async {
    final image = await pickImageFromStorage();
    if (image != null) {
      setState(() {
        _selectedCoverFile = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaylistBloc, PlaylistState>(
      listener: (context, state) {
        if (state is CreatePlaylistLoaded) {
          context.pop();
        } else if (state is CreatePlaylistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.message), backgroundColor: ThemeColors.red),
          );
        }
      },
      child: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Playlist'),
              backgroundColor: ThemeColors.primaryColor,
              foregroundColor: ThemeColors.white,
              elevation: 0,
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed:
                      state is CreatePlaylistLoading ? null : _createPlaylist,
                  child: Text(
                    state is CreatePlaylistLoading ? 'Creating...' : 'Save',
                    style: TextStyle(
                      color: state is CreatePlaylistLoading
                          ? ThemeColors.white70
                          : ThemeColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPlaylistInfoCard(),
                        const SizedBox(height: 16),
                        _buildCoverImageCard(),
                        const SizedBox(height: 32),
                        _buildCreateButton(state),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                if (state is CreatePlaylistLoading)
                  LoadingOverlay(
                    title: 'Creating Playlist',
                    message: 'Please wait while we upload your playlist...',
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaylistInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Playlist Information',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _playlistNameController,
              decoration: const InputDecoration(
                labelText: 'Playlist Name *',
                hintText: 'Enter playlist name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.queue_music),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter playlist name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter playlist description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Public Playlist'),
              subtitle: const Text('Make this playlist visible to all users'),
              value: _isPublic,
              onChanged: (value) {
                setState(() {
                  _isPublic = value;
                });
              },
              activeColor: ThemeColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImageCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cover Image',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickCoverFromStorage,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ThemeColors.grey200,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  image: _selectedCoverFile != null
                      ? DecorationImage(
                          image: FileImage(_selectedCoverFile!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: _selectedCoverFile == null
                    ? _buildEmptyCoverImage()
                    : _buildCoverImagePreview(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCoverImage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.image,
          size: 64,
          color: ThemeColors.grey,
        ),
        const SizedBox(height: 8),
        Text(
          'Upload Cover Image',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ThemeColors.grey600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          'JPG, PNG supported • Recommended: 500x500px',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: ThemeColors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildCoverImagePreview() {
    return Stack(
      children: [
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedCoverFile = null;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black54,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton(PlaylistState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is CreatePlaylistLoading ? null : _createPlaylist,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.primaryColor,
          foregroundColor: ThemeColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: state is CreatePlaylistLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.white),
                ),
              )
            : const Text(
                'Create Playlist',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  void _createPlaylist() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCoverFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a cover image'),
            backgroundColor: ThemeColors.red,
          ),
        );
        return;
      }

      final params = UserPlaylistParams(
        name: _playlistNameController.text.trim(),
        bio: _descriptionController.text.trim(),
        coverFile: _selectedCoverFile!,
        isPublic: _isPublic,
      );

      getIt<PlaylistBloc>().add(CreatePlaylist(params));
    }
  }
}
