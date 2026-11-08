import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/models/card_training.dart';

enum NeutralStimulus {
  circle,
  triangle,
  square,
  star,
  diamond,
  cross,
}

class TrainingOption {
  TrainingOption.card({
    required CardTraining this.card,
    required AppImage this.image,
  })  : label = card.label,
        neutralStimulus = null;

  const TrainingOption.neutral(NeutralStimulus stimulus)
      : card = null,
        image = null,
        label = 'neutral',
        neutralStimulus = stimulus;

  final CardTraining? card;
  final AppImage? image;
  final String label;
  final NeutralStimulus? neutralStimulus;
}
