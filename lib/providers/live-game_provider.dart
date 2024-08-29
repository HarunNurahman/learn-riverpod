import 'package:equatable/equatable.dart';
import 'package:learn_riverpod/models/game_model.dart';
import 'package:learn_riverpod/services/game_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live-game_provider.g.dart';

@riverpod
class LiveGameNotifier extends _$LiveGameNotifier {
  @override
  LiveGameState build() => const LiveGameState('', '', []);

  fetchLiveGames() async {
    state = const LiveGameState('Loading', '', []);
    final games = await GameService.getLiveGames();
    if (games == null) {
      state = const LiveGameState('Failed', 'Server Error', []);
    }
    state = LiveGameState('Success', '', games);
  }

  changeIsSaved(GameModel newGame) {
    int index = state.data!.indexWhere((element) => element.id == newGame.id);
    state.data![index] = newGame;
    state = LiveGameState('Success', '', [...state.data!]);
  }
}

class LiveGameState extends Equatable {
  final String? status;
  final String? message;
  final List<GameModel>? data;

  const LiveGameState(this.status, this.message, this.data);

  @override
  List<Object?> get props => [status, message, data];
}
