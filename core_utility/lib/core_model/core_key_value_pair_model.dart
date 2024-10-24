class CoreKeyValuePairModel<T, R, S> {
  CoreKeyValuePairModel({
    required this.key,
    required this.value,
    this.extra,
  });

   T key;
   R value;
   S? extra;
}
