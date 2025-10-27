import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groovix/core/models/playlist_model.dart';
import 'package:groovix/core/theme/app_theme.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_bloc.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_event.dart';
import 'package:groovix/features/shared/playlist/bloc/playlist_state.dart';
import 'package:groovix/features/shared/playlist/domain/models/playlist_update.dart';
import 'package:groovix/features/shared/playlist/domain/models/update_playlist_params.dart';
import 'package:groovix/features/cms/shared/widgets/loading_overlay.dart';

class CMSEditPlaylistScreen extends StatefulWidget {
  final PlaylistModel playlist;

  const CMSEditPlaylistScreen({super.key, required this.playlist});

  @override
  State<CMSEditPlaylistScreen> createState() => _CMSEditPlaylistScreenState();
}

class _CMSEditPlaylistScreenState extends State<CMSEditPlaylistScreen> {
  final _formKey = GlobalKey<FormState>();
  final _playlistNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _isPublic = false;

  @override
  void initState() {
    super.initState();
    _playlistNameController.text = widget.playlist.name;
    _descriptionController.text = widget.playlist.bio;
    _isPublic = widget.playlist.isPublic == 'true';
  }

  @override
  void dispose() {
    _playlistNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlaylistBloc, PlaylistState>(
      listener: (context, state) {
        if (state is UpdatePlaylistLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Playlist updated successfully!'),
              backgroundColor: ThemeColors.clrGreen,
            ),
          );
          Navigator.pop(context);
        } else if (state is UpdatePlaylistError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.message}'),
              backgroundColor: ThemeColors.red,
            ),
          );
        }
      },
      child: BlocBuilder<PlaylistBloc, PlaylistState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? ThemeColors.darkAppColor
                : ThemeColors.white,
            appBar: AppBar(
              title: const Text('Edit Playlist'),
              backgroundColor: ThemeColors.primaryColor,
              foregroundColor: ThemeColors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
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
                        _buildCoverImageDisplay(),
                        const SizedBox(height: 32),
                        _buildUpdateButton(state),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                if (state is UpdatePlaylistLoading)
                  LoadingOverlay(
                    title: 'Updating Playlist',
                    message: 'Please wait while we update your playlist...',
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

  Widget _buildCoverImageDisplay() {
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
            if (widget.playlist.coverUrl.isNotEmpty)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.playlist.coverUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // Handle error
                    },
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: ThemeColors.grey200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 64, color: ThemeColors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateButton(PlaylistState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is UpdatePlaylistLoading ? null : _updatePlaylist,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColors.primaryColor,
          foregroundColor: ThemeColors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: state is UpdatePlaylistLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.white),
                ),
              )
            : const Text(
                'Update Playlist',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }

  void _updatePlaylist() {
    if (_formKey.currentState!.validate()) {
      final playlistUpdate = PlaylistUpdate(
        name: _playlistNameController.text.trim(),
        bio: _descriptionController.text.trim(),
        isPublic: _isPublic ? 'true' : 'false',
      );

      final params = UpdatePlaylistParams(
        playlistId: widget.playlist.id,
        update: playlistUpdate,
      );

      context
          .read<PlaylistBloc>()
          .add(UpdatePlaylist(widget.playlist.id, params));
    }
  }
}
