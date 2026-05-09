import 'dart:io';

import 'activation.dart';

class Perceptron {
  final List<num> initWts;
  final List<List<num>> inputs;
  const Perceptron({required this.initWts, required this.inputs});

  List<num> train({required int epoch, required double learningRate}) {
    List<num> wts = initWts;
    for (int i = 0; i < epoch; i++) {
      int count = 0;
      for (int j = 0; j < inputs.length; j++) {
        var (correct, ans) = verify(
          wts: wts,
          input: inputs[j],
          fn: Activation.heaviside,
        );
        if (!correct) {
          for (int k = 0; k < wts.length - 1; k++) {
            wts[k] += (inputs[j].last - ans) * learningRate * inputs[j][k];
          }
          wts.last += (inputs[j].last - ans) * learningRate * 1;
        } else {
          count++;
        }
      }
      double acurracy = count / inputs.length;
      if (i % 200 == 0) {
        print("Accurracy: $acurracy, Weight: $wts");
      }
      if (acurracy > .98) {
        print("Final Weights at epoch: $i, Accurracy: $acurracy, wts: $wts");
        break;
      }
    }

    print("Complete");
    return wts;
  }

  (bool, num) verify({
    required List<num> wts,
    required List<num> input,
    required Activation fn,
  }) {
    num ans = activate(wts: wts, input: input, fn: fn);
    return ans == input.last ? (true, ans) : (false, ans);
  }

  bool inference({
    required List<num> wts,
    required List<num> input,
    Activation fn = Activation.heaviside,
  }) {
    return activate(wts: wts, input: input, fn: fn) == 1 ? true : false;
  }
}

void main(List<String> args) {
  List<(num, num, num)> data = [
    (11, 83, 0),
    (18, 65, 0),
    (19, 37, 0),
    (14, 22, 0),
    (11, 12, 0),
    (29, 10, 0),
    (35, 15, 0),
    (32, 27, 0),
    (43, 37, 0),
    (31, 50, 0),
    (10, 52, 0),
    (52, 14, 0),
    (33, 92, 1),
    (45, 84, 1),
    (60, 68, 1),
    (61, 85, 1),
    (85, 90, 1),
    (91, 79, 1),
    (86, 66, 1),
    (78, 59, 1),
    (77, 75, 1),
    (68, 53, 1),
    (78, 40, 1),
    (78, 22, 1),
    (93, 28, 1),
  ];
  List<num> initWts = [0, 0, -1];
  Perceptron p1 = Perceptron(
    initWts: initWts,
    inputs: data.map((r) => [r.$1, r.$2, r.$3]).toList(),
  );
  //Training
  final trainedWts = p1.train(epoch: 10000, learningRate: .0001);

  print('\nLearned weights : ${trainedWts.sublist(0, 2)}');
  print('Learned bias    : ${trainedWts.last}\n');
  //Infernece
  while (true) {
    stdout.write('Grade (0–100): ');
    final rawGrade = stdin.readLineSync()?.trim();
    if (rawGrade == null || rawGrade.toLowerCase() == 'exit') break;

    stdout.write('Test score (0–100): ');
    final rawScore = stdin.readLineSync()?.trim();
    if (rawScore == null || rawScore.toLowerCase() == 'exit') break;

    final grade = num.tryParse(rawGrade);
    final score = num.tryParse(rawScore);

    if (grade == null || score == null) {
      print('  ⚠  Please enter valid numbers.\n');
      continue;
    }

    final output = p1.inference(wts: trainedWts, input: [grade, score]);

    print(output ? 'Pass ✓' : 'Fail ✗');
  }

  print('Goodbye.');
}
