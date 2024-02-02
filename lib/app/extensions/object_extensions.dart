extension ObjectExtension<T> on T {
  R let<R>(R Function(T it) operation) => operation(this);
}
