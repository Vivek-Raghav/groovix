// States

// Package imports:
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:groovix/features/cms/cms_index.dart';

abstract class CmsArtistState extends Equatable {
  const CmsArtistState();
  @override
  List<Object> get props => [];
}

class CmsArtistInitial extends CmsArtistState {}

// Get All Artists

class CmsArtistLoading extends CmsArtistState {}

class CmsArtistLoaded extends CmsArtistState {
  final List<ArtistModel> artists;
  const CmsArtistLoaded(this.artists);
}

class CmsArtistError extends CmsArtistState {
  final String message;
  const CmsArtistError(this.message);
}

// Delete Artist states

class ArtistDeletedLoading extends CmsArtistState {}

class ArtistDeleted extends CmsArtistState {
  final String artistId;
  const ArtistDeleted(this.artistId);
}

class ArtistDeletedError extends CmsArtistState {
  final String message;
  const ArtistDeletedError(this.message);
}

// Create Artist states

class CreateArtistLoading extends CmsArtistState {}

class CreateArtistSuccess extends CmsArtistState {
  final ArtistModel artist;
  const CreateArtistSuccess({required this.artist});
  @override
  List<Object> get props => [artist];
}

class CreateArtistFailure extends CmsArtistState {
  final String error;
  const CreateArtistFailure({required this.error});
  @override
  List<Object> get props => [error];
}

// Update Artist states

class UpdateArtistLoading extends CmsArtistState {}

class UpdateArtistSuccess extends CmsArtistState {
  final ArtistModel artist;
  const UpdateArtistSuccess(this.artist);
  @override
  List<Object> get props => [artist];
}

class UpdateArtistFailure extends CmsArtistState {
  final String error;
  const UpdateArtistFailure({required this.error});
  @override
  List<Object> get props => [error];
}
