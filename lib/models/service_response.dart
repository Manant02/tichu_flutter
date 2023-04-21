class ServiceResponse<T> {
  final String? err;
  final T? ret;

  ServiceResponse(
    this.err,
    this.ret,
  );
}
