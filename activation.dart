enum Activation { heaviside, relu }

int heavisideStep({required List wts, required List input}) {
  num sum = wts.last * 1;
  for (int i = 0; i < wts.length - 1; i++) {
    sum += wts[i] * input[i];
  }
  return sum >= 0 ? 1 : 0;
}

num activate({required List wts, required List input, required Activation fn}) {
  switch (fn) {
    case Activation.heaviside:
      return heavisideStep(input: input, wts: wts);
    default:
      return heavisideStep(input: input, wts: wts);
  }
}
