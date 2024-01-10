enum APIState {
  init,
  loading,
  error,
  success,
}

enum CategoryAPIState {
  init,
  loading,
  loadingSubs,
  error,
  errorSubs,
  success,
}

enum SearchAPIState {
  init,
  loading,
  loadingMore,
  error,
  errorMore,
  success,
}

enum PaginatedApiState {
  init,
  loading,
  loadingMore,
  error,
  errorMore,
  success,
}

// enum VideoAPIState {
//   init,
//   loading,
//   loadingMore,
//   error,
//   errorMore,
//   success,
// }

enum FavorsAPIState {
  init,
  loading,
  loadingMore,
  error,
  errorMore,
  success,
  unauthorized
}

enum OrderHistoryAPIState {
  init,
  loading,
  loadingMore,
  error,
  errorMore,
  success,
  unauthorized,
}

enum AddressApiState {
  init,
  loading,
  error,
  succses,
  unAuthorized,
}

enum CartAPIState {
  unAuthorized,
  init,
  loading,
  error,
  success,
}

enum LocalDataKeys {
  token,
  lang,
}

enum ProductAPIState {
  init,
  loading,
  loadingMore,
  loadingMoreError,
  error,
  success,
}

enum ProdDetailsAPIState {
  init,
  loading,
  error,
  success,
}

enum FilterAPIState {
  init,
  loading,
  error,
  success,
}
