# flutter_with_clean_architecture


### Clean Architecture

```
3 Layers

Presentation
  Widgets
  Presentation logic holders
    -> BLoC, ChnageNotifier
    
Domain
  Use cases
    -> Business logic of particular usecase
    ex) Get concrete number trivia, Get random number trivia
  Entities
  Repositories
    -> On the edge between data and domain layers.
    
Data
  -> Define how data will be gotten and managed
  Repositories
    -> Brain of data layer.
  Remote data sources
    -> API
  Local data sources
    -> DB, shared preference
```
