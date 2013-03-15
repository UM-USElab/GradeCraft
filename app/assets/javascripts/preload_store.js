!function(app) {
  var data = {};

  app.preloadStore = {};

  var set = function(k, v) {
    data[k] = v; 
  };
  app.preloadStore.set = set;

  var get = function(k, d) {
    if (!contains(k)) return d;
    var value = data[k];
    delete data[k];
    return value;
  };
  app.preloadStore.get = get;

  var contains = function(k) {
    return data[k] !== undefined;
  };
  app.preloadStore.contains = contains;
}(Gradecraft);
