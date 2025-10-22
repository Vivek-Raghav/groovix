// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:groovix/core/core_index.dart';
import 'package:groovix/core/shared/widgets/common_back_button.dart';

class UniversalEditForm extends StatefulWidget {
  final String type;
  final Map<String, dynamic> initialData;
  final List<FormField> fields;
  final Function(Map<String, dynamic>) onSave;
  final bool isLoading;

  const UniversalEditForm({
    super.key,
    required this.type,
    required this.initialData,
    required this.fields,
    required this.onSave,
    this.isLoading = false,
  });

  @override
  State<UniversalEditForm> createState() => _UniversalEditFormState();
}

class _UniversalEditFormState extends State<UniversalEditForm> {
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, dynamic> _formData = {};

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    for (final field in widget.fields) {
      _controllers[field.key] = TextEditingController(
        text: widget.initialData[field.key]?.toString() ?? '',
      );
      _formData[field.key] = widget.initialData[field.key];
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? ThemeColors.darkAppColor : ThemeColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, isDark),
              const SizedBox(height: 24),
              _buildPreviewCard(context, isDark),
              const SizedBox(height: 24),
              _buildFormFields(context, isDark),
              const SizedBox(height: 24),
              _buildSaveButton(context, isDark),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CommonBackButton(),
        Text(
          'Edit ${_capitalizeFirst(widget.type)}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: isDark ? ThemeColors.white : ThemeColors.black,
            fontFamily: 'Lexend',
          ),
        ),
        IconButton(
          onPressed: widget.isLoading ? null : _saveForm,
          icon: Icon(
            _getSaveIcon(),
            color: widget.isLoading
                ? (isDark ? ThemeColors.white70 : ThemeColors.grey600)
                : (isDark ? ThemeColors.white : ThemeColors.black),
            size: 30,
          ),
          tooltip: 'Save Changes',
        ),
      ],
    );
  }

  Widget _buildPreviewCard(BuildContext context, bool isDark) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? ThemeColors.darkSurfaceColor : ThemeColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? ThemeColors.white30 : ThemeColors.grey300,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: _getTypeColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getTypeIcon(),
                color: _getTypeColor(),
                size: 40,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.initialData['name'] ??
                        widget.initialData['title'] ??
                        'Preview',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark ? ThemeColors.white : ThemeColors.black,
                      fontFamily: 'Lexend',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _capitalizeFirst(widget.type),
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
                      fontFamily: 'Lexend',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context, bool isDark) {
    return Column(
      children: widget.fields.map((field) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildFormField(field, isDark),
        );
      }).toList(),
    );
  }

  Widget _buildFormField(FormField field, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          field.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isDark ? ThemeColors.white : ThemeColors.black,
            fontFamily: 'Lexend',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark ? ThemeColors.darkSurfaceColor : ThemeColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? ThemeColors.white30 : ThemeColors.grey300,
            ),
          ),
          child: TextField(
            controller: _controllers[field.key],
            style: TextStyle(
              color: isDark ? ThemeColors.white : ThemeColors.black,
              fontFamily: 'Lexend',
            ),
            decoration: InputDecoration(
              hintText: field.placeholder,
              hintStyle: TextStyle(
                color: isDark ? ThemeColors.white70 : ThemeColors.grey600,
                fontFamily: 'Lexend',
              ),
              prefixIcon: Icon(
                field.icon,
                color: _getTypeColor(),
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            onChanged: (value) {
              _formData[field.key] = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            _getTypeColor(),
            _getTypeColor().withOpacity(0.8),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : _saveForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getSaveIcon(),
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              widget.isLoading ? 'Saving...' : 'Save Changes',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Lexend',
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (widget.type.toLowerCase()) {
      case 'song':
        return Icons.music_note;
      case 'artist':
        return Icons.person;
      case 'playlist':
        return Icons.playlist_play;
      case 'genre':
        return Icons.category;
      default:
        return Icons.edit;
    }
  }

  IconData _getSaveIcon() {
    switch (widget.type.toLowerCase()) {
      case 'song':
        return Icons.music_note;
      case 'artist':
        return Icons.person;
      case 'playlist':
        return Icons.playlist_play;
      case 'genre':
        return Icons.category;
      default:
        return Icons.save;
    }
  }

  Color _getTypeColor() {
    switch (widget.type.toLowerCase()) {
      case 'song':
        return ThemeColors.primaryColor;
      case 'artist':
        return Colors.purple;
      case 'playlist':
        return Colors.orange;
      case 'genre':
        return Colors.teal;
      default:
        return ThemeColors.primaryColor;
    }
  }

  String _capitalizeFirst(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _saveForm() {
    widget.onSave(_formData);
  }
}

class FormField {
  final String key;
  final String label;
  final String placeholder;
  final IconData icon;

  const FormField({
    required this.key,
    required this.label,
    required this.placeholder,
    required this.icon,
  });
}
