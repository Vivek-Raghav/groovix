import "package:go_router/go_router.dart";
import "package:groovix/core/core_index.dart";
import "package:groovix/core/shared/connectivity/presentation/screens/offline_screen.dart";
import "../bloc/connectivity_bloc.dart";
import "../bloc/events_states.dart";

class AppErrorScreen extends StatelessWidget {
  const AppErrorScreen({
    required this.msg,
    this.onRetry,
    super.key,
  });

  final String? msg;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (!state.status.isOnline) {
          return const AppOfflineScreen();
        }

        return Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  msg ?? StringConstants.strSomethingWentWrong,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                      ),
                ),
                const SizedBox(height: 24),
                // if (onRetry != null)
                ElevatedButton(
                    onPressed: onRetry ?? () => context.pop(),
                    child: Text(onRetry == null
                        ? StringConstants.strGoBack
                        : StringConstants.strRetry)),
              ],
            ),
          ),
        );
      },
    );
  }
}
