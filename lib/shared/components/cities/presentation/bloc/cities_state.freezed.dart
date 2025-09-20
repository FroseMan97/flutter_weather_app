// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cities_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CitiesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<City> cities, bool showSuggestions) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<City> cities, bool showSuggestions)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<City> cities, bool showSuggestions)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CitiesInitial value) initial,
    required TResult Function(CitiesLoading value) loading,
    required TResult Function(CitiesLoaded value) loaded,
    required TResult Function(CitiesError value) error,
    required TResult Function(CitiesEmpty value) empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CitiesInitial value)? initial,
    TResult? Function(CitiesLoading value)? loading,
    TResult? Function(CitiesLoaded value)? loaded,
    TResult? Function(CitiesError value)? error,
    TResult? Function(CitiesEmpty value)? empty,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CitiesInitial value)? initial,
    TResult Function(CitiesLoading value)? loading,
    TResult Function(CitiesLoaded value)? loaded,
    TResult Function(CitiesError value)? error,
    TResult Function(CitiesEmpty value)? empty,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CitiesStateCopyWith<$Res> {
  factory $CitiesStateCopyWith(
          CitiesState value, $Res Function(CitiesState) then) =
      _$CitiesStateCopyWithImpl<$Res, CitiesState>;
}

/// @nodoc
class _$CitiesStateCopyWithImpl<$Res, $Val extends CitiesState>
    implements $CitiesStateCopyWith<$Res> {
  _$CitiesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CitiesInitialImplCopyWith<$Res> {
  factory _$$CitiesInitialImplCopyWith(
          _$CitiesInitialImpl value, $Res Function(_$CitiesInitialImpl) then) =
      __$$CitiesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CitiesInitialImplCopyWithImpl<$Res>
    extends _$CitiesStateCopyWithImpl<$Res, _$CitiesInitialImpl>
    implements _$$CitiesInitialImplCopyWith<$Res> {
  __$$CitiesInitialImplCopyWithImpl(
      _$CitiesInitialImpl _value, $Res Function(_$CitiesInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CitiesInitialImpl implements CitiesInitial {
  const _$CitiesInitialImpl();

  @override
  String toString() {
    return 'CitiesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CitiesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<City> cities, bool showSuggestions) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<City> cities, bool showSuggestions)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<City> cities, bool showSuggestions)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CitiesInitial value) initial,
    required TResult Function(CitiesLoading value) loading,
    required TResult Function(CitiesLoaded value) loaded,
    required TResult Function(CitiesError value) error,
    required TResult Function(CitiesEmpty value) empty,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CitiesInitial value)? initial,
    TResult? Function(CitiesLoading value)? loading,
    TResult? Function(CitiesLoaded value)? loaded,
    TResult? Function(CitiesError value)? error,
    TResult? Function(CitiesEmpty value)? empty,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CitiesInitial value)? initial,
    TResult Function(CitiesLoading value)? loading,
    TResult Function(CitiesLoaded value)? loaded,
    TResult Function(CitiesError value)? error,
    TResult Function(CitiesEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class CitiesInitial implements CitiesState {
  const factory CitiesInitial() = _$CitiesInitialImpl;
}

/// @nodoc
abstract class _$$CitiesLoadingImplCopyWith<$Res> {
  factory _$$CitiesLoadingImplCopyWith(
          _$CitiesLoadingImpl value, $Res Function(_$CitiesLoadingImpl) then) =
      __$$CitiesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CitiesLoadingImplCopyWithImpl<$Res>
    extends _$CitiesStateCopyWithImpl<$Res, _$CitiesLoadingImpl>
    implements _$$CitiesLoadingImplCopyWith<$Res> {
  __$$CitiesLoadingImplCopyWithImpl(
      _$CitiesLoadingImpl _value, $Res Function(_$CitiesLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CitiesLoadingImpl implements CitiesLoading {
  const _$CitiesLoadingImpl();

  @override
  String toString() {
    return 'CitiesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CitiesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<City> cities, bool showSuggestions) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<City> cities, bool showSuggestions)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<City> cities, bool showSuggestions)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CitiesInitial value) initial,
    required TResult Function(CitiesLoading value) loading,
    required TResult Function(CitiesLoaded value) loaded,
    required TResult Function(CitiesError value) error,
    required TResult Function(CitiesEmpty value) empty,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CitiesInitial value)? initial,
    TResult? Function(CitiesLoading value)? loading,
    TResult? Function(CitiesLoaded value)? loaded,
    TResult? Function(CitiesError value)? error,
    TResult? Function(CitiesEmpty value)? empty,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CitiesInitial value)? initial,
    TResult Function(CitiesLoading value)? loading,
    TResult Function(CitiesLoaded value)? loaded,
    TResult Function(CitiesError value)? error,
    TResult Function(CitiesEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class CitiesLoading implements CitiesState {
  const factory CitiesLoading() = _$CitiesLoadingImpl;
}

/// @nodoc
abstract class _$$CitiesLoadedImplCopyWith<$Res> {
  factory _$$CitiesLoadedImplCopyWith(
          _$CitiesLoadedImpl value, $Res Function(_$CitiesLoadedImpl) then) =
      __$$CitiesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<City> cities, bool showSuggestions});
}

/// @nodoc
class __$$CitiesLoadedImplCopyWithImpl<$Res>
    extends _$CitiesStateCopyWithImpl<$Res, _$CitiesLoadedImpl>
    implements _$$CitiesLoadedImplCopyWith<$Res> {
  __$$CitiesLoadedImplCopyWithImpl(
      _$CitiesLoadedImpl _value, $Res Function(_$CitiesLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cities = null,
    Object? showSuggestions = null,
  }) {
    return _then(_$CitiesLoadedImpl(
      cities: null == cities
          ? _value._cities
          : cities // ignore: cast_nullable_to_non_nullable
              as List<City>,
      showSuggestions: null == showSuggestions
          ? _value.showSuggestions
          : showSuggestions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CitiesLoadedImpl implements CitiesLoaded {
  const _$CitiesLoadedImpl(
      {required final List<City> cities, this.showSuggestions = false})
      : _cities = cities;

  final List<City> _cities;
  @override
  List<City> get cities {
    if (_cities is EqualUnmodifiableListView) return _cities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cities);
  }

  @override
  @JsonKey()
  final bool showSuggestions;

  @override
  String toString() {
    return 'CitiesState.loaded(cities: $cities, showSuggestions: $showSuggestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CitiesLoadedImpl &&
            const DeepCollectionEquality().equals(other._cities, _cities) &&
            (identical(other.showSuggestions, showSuggestions) ||
                other.showSuggestions == showSuggestions));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_cities), showSuggestions);

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CitiesLoadedImplCopyWith<_$CitiesLoadedImpl> get copyWith =>
      __$$CitiesLoadedImplCopyWithImpl<_$CitiesLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<City> cities, bool showSuggestions) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return loaded(cities, showSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<City> cities, bool showSuggestions)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return loaded?.call(cities, showSuggestions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<City> cities, bool showSuggestions)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(cities, showSuggestions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CitiesInitial value) initial,
    required TResult Function(CitiesLoading value) loading,
    required TResult Function(CitiesLoaded value) loaded,
    required TResult Function(CitiesError value) error,
    required TResult Function(CitiesEmpty value) empty,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CitiesInitial value)? initial,
    TResult? Function(CitiesLoading value)? loading,
    TResult? Function(CitiesLoaded value)? loaded,
    TResult? Function(CitiesError value)? error,
    TResult? Function(CitiesEmpty value)? empty,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CitiesInitial value)? initial,
    TResult Function(CitiesLoading value)? loading,
    TResult Function(CitiesLoaded value)? loaded,
    TResult Function(CitiesError value)? error,
    TResult Function(CitiesEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class CitiesLoaded implements CitiesState {
  const factory CitiesLoaded(
      {required final List<City> cities,
      final bool showSuggestions}) = _$CitiesLoadedImpl;

  List<City> get cities;
  bool get showSuggestions;

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CitiesLoadedImplCopyWith<_$CitiesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CitiesErrorImplCopyWith<$Res> {
  factory _$$CitiesErrorImplCopyWith(
          _$CitiesErrorImpl value, $Res Function(_$CitiesErrorImpl) then) =
      __$$CitiesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$CitiesErrorImplCopyWithImpl<$Res>
    extends _$CitiesStateCopyWithImpl<$Res, _$CitiesErrorImpl>
    implements _$$CitiesErrorImplCopyWith<$Res> {
  __$$CitiesErrorImplCopyWithImpl(
      _$CitiesErrorImpl _value, $Res Function(_$CitiesErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$CitiesErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CitiesErrorImpl implements CitiesError {
  const _$CitiesErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'CitiesState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CitiesErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CitiesErrorImplCopyWith<_$CitiesErrorImpl> get copyWith =>
      __$$CitiesErrorImplCopyWithImpl<_$CitiesErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<City> cities, bool showSuggestions) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<City> cities, bool showSuggestions)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<City> cities, bool showSuggestions)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CitiesInitial value) initial,
    required TResult Function(CitiesLoading value) loading,
    required TResult Function(CitiesLoaded value) loaded,
    required TResult Function(CitiesError value) error,
    required TResult Function(CitiesEmpty value) empty,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CitiesInitial value)? initial,
    TResult? Function(CitiesLoading value)? loading,
    TResult? Function(CitiesLoaded value)? loaded,
    TResult? Function(CitiesError value)? error,
    TResult? Function(CitiesEmpty value)? empty,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CitiesInitial value)? initial,
    TResult Function(CitiesLoading value)? loading,
    TResult Function(CitiesLoaded value)? loaded,
    TResult Function(CitiesError value)? error,
    TResult Function(CitiesEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class CitiesError implements CitiesState {
  const factory CitiesError(final String message) = _$CitiesErrorImpl;

  String get message;

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CitiesErrorImplCopyWith<_$CitiesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CitiesEmptyImplCopyWith<$Res> {
  factory _$$CitiesEmptyImplCopyWith(
          _$CitiesEmptyImpl value, $Res Function(_$CitiesEmptyImpl) then) =
      __$$CitiesEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CitiesEmptyImplCopyWithImpl<$Res>
    extends _$CitiesStateCopyWithImpl<$Res, _$CitiesEmptyImpl>
    implements _$$CitiesEmptyImplCopyWith<$Res> {
  __$$CitiesEmptyImplCopyWithImpl(
      _$CitiesEmptyImpl _value, $Res Function(_$CitiesEmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of CitiesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CitiesEmptyImpl implements CitiesEmpty {
  const _$CitiesEmptyImpl();

  @override
  String toString() {
    return 'CitiesState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CitiesEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<City> cities, bool showSuggestions) loaded,
    required TResult Function(String message) error,
    required TResult Function() empty,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<City> cities, bool showSuggestions)? loaded,
    TResult? Function(String message)? error,
    TResult? Function()? empty,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<City> cities, bool showSuggestions)? loaded,
    TResult Function(String message)? error,
    TResult Function()? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CitiesInitial value) initial,
    required TResult Function(CitiesLoading value) loading,
    required TResult Function(CitiesLoaded value) loaded,
    required TResult Function(CitiesError value) error,
    required TResult Function(CitiesEmpty value) empty,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CitiesInitial value)? initial,
    TResult? Function(CitiesLoading value)? loading,
    TResult? Function(CitiesLoaded value)? loaded,
    TResult? Function(CitiesError value)? error,
    TResult? Function(CitiesEmpty value)? empty,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CitiesInitial value)? initial,
    TResult Function(CitiesLoading value)? loading,
    TResult Function(CitiesLoaded value)? loaded,
    TResult Function(CitiesError value)? error,
    TResult Function(CitiesEmpty value)? empty,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class CitiesEmpty implements CitiesState {
  const factory CitiesEmpty() = _$CitiesEmptyImpl;
}
