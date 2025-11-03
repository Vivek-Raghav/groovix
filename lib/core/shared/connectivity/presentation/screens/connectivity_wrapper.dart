import "package:groovix/core/shared/connectivity/presentation/screens/offline_screen.dart";

import "../../../../../routes/routes_index.dart";
import "../bloc/connectivity_bloc.dart";
import "../bloc/events_states.dart";

class ConnectivityWrapper extends StatelessWidget {
  const ConnectivityWrapper({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ConnectivityBloc>(),
      child: BlocConsumer<ConnectivityBloc, ConnectivityState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          // Optional: Handle connectivity changes that require navigation
          if (!state.status.isOnline) {
            // Handle offline state without triggering navigation
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (!state.status.isOnline) {
            return Material(
              child: Column(
                children: [
                  const AppOfflineBanner(),
                  Expanded(child: child),
                ],
              ),
            );
          }
          return child;
        },
      ),
    );
  }
}
