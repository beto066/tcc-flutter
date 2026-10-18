import 'package:flutter/material.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/stores/card_store.dart';
import 'package:tccflutter/widgets/molecules/wrap_card_training.dart';

class CardTrainingList extends StatefulWidget {

  const CardTrainingList({
    super.key,
  });

  @override
  State<CardTrainingList> createState() => _CardTrainingListState();
}

class _CardTrainingListState extends State<CardTrainingList> {
  final ScrollController _controller = ScrollController();

  final List<CardTraining> _cards = [];

  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadPage();

    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        _loadPage();
      }
    });
  }

  Future<void> _loadPage() async {
    if (_loading || !_hasMore) return;

    setState(() => _loading = true);

    final result = await CardStore().paginateCards(page: _page);

    if (result.isEmpty) {
      _hasMore = false;
    } else {
      _cards.addAll(result);
      _page++;
    }

    if (mounted) {
      setState(() => _loading = false);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !_controller.hasClients) return;
        if (_controller.position.maxScrollExtent <= 0 && _hasMore) {
          _loadPage();
        }
      });
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      itemCount: _cards.length + (_loading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= _cards.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final card = _cards[index];

        return WrapCardTraining(
          key: ValueKey('${card.label}_${card.images?.length}_${card.images?.fold('', (prev, img) => '${prev}_${img.path}_${img.existsSync() ? img.lastModifiedSync().microsecondsSinceEpoch : ''}')}'),
          card: card,
          onCardChanged: () {
            setState(() {});
          },
          onCardDeleted: () {
            setState(() {
              _cards.removeWhere((c) => c.label == card.label);
            });
          },
        );
      },
    );
  }
}
