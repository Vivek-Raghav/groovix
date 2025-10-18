import '../../cms_index.dart';

// Events
abstract class DashboardEvent {}

class LoadDashboardStats extends DashboardEvent {}

// States
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final DashboardStats stats;
  DashboardLoaded(this.stats);
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}

// BLoC
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardBloc(this._dashboardRepository) : super(DashboardInitial()) {
    on<LoadDashboardStats>(_onLoadDashboardStats);
  }

  Future<void> _onLoadDashboardStats(
      LoadDashboardStats event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    try {
      final stats = await _dashboardRepository.getDashboardStats();
      emit(DashboardLoaded(stats));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }
}
