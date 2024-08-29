import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod/models/game_model.dart';
import 'package:learn_riverpod/providers/genre_provider.dart';
import 'package:learn_riverpod/providers/live-game_provider.dart';

class LiveGamePage extends ConsumerStatefulWidget {
  const LiveGamePage({super.key});

  @override
  ConsumerState<LiveGamePage> createState() => _LiveGamePageState();
}

class _LiveGamePageState extends ConsumerState<LiveGamePage> {
  List<String> genres = ['Shooter', 'MMOARPG', 'ARPG', 'Strategy', 'Fighting'];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(liveGameNotifierProvider.notifier).fetchLiveGames();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live Games',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          Consumer(
            builder: (context, wiRef, child) {
              String selectedGenre = wiRef.watch(genreNotifierProvider);
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: genres
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ActionChip(
                              onPressed: () {
                                ref
                                    .read(genreNotifierProvider.notifier)
                                    .onChange(e);
                              },
                              label: Text(
                                e,
                                style: TextStyle(
                                  color: selectedGenre == e
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              backgroundColor: selectedGenre == e
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Consumer(
              builder: (context, wiRef, child) {
                LiveGameState state = wiRef.watch(liveGameNotifierProvider);

                if (state.status == '') return const SizedBox.shrink();
                if (state.status == 'Loading') {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == 'Failed') {
                  return Center(
                    child: Text('Failed to fetch live games ${state.message}'),
                  );
                }
                List<GameModel> gameList = state.data!;
                String genreSelected = wiRef.watch(genreNotifierProvider);

                List<GameModel> games = gameList
                    .where((element) => element.genre == genreSelected)
                    .toList();
                return GridView.builder(
                  itemCount: games.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    GameModel game = games[index];
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: ExtendedImage.network(
                            game.thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 40,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            onPressed: () {
                              GameModel newGame = game.copyWith(
                                isSaved: !game.isSaved,
                              );
                              ref
                                  .read(liveGameNotifierProvider.notifier)
                                  .changeIsSaved(newGame);
                            },
                            icon: Icon(
                              game.isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_outline,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
