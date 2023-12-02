extension LetExtension<T, R> on T {
  R let(R Function(T it) operate) => operate(this);
}
