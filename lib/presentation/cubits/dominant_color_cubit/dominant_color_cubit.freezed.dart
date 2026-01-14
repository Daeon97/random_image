// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dominant_color_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DominantColorState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DominantColorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DominantColorState()';
}


}

/// @nodoc
class $DominantColorStateCopyWith<$Res>  {
$DominantColorStateCopyWith(DominantColorState _, $Res Function(DominantColorState) __);
}


/// Adds pattern-matching-related methods to [DominantColorState].
extension DominantColorStatePatterns on DominantColorState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _GeneratingColor value)?  generatingColor,TResult Function( _GeneratedColor value)?  generatedColor,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GeneratingColor() when generatingColor != null:
return generatingColor(_that);case _GeneratedColor() when generatedColor != null:
return generatedColor(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _GeneratingColor value)  generatingColor,required TResult Function( _GeneratedColor value)  generatedColor,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _GeneratingColor():
return generatingColor(_that);case _GeneratedColor():
return generatedColor(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _GeneratingColor value)?  generatingColor,TResult? Function( _GeneratedColor value)?  generatedColor,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GeneratingColor() when generatingColor != null:
return generatingColor(_that);case _GeneratedColor() when generatedColor != null:
return generatedColor(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  generatingColor,TResult Function( Color? dominantColor)?  generatedColor,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GeneratingColor() when generatingColor != null:
return generatingColor();case _GeneratedColor() when generatedColor != null:
return generatedColor(_that.dominantColor);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  generatingColor,required TResult Function( Color? dominantColor)  generatedColor,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _GeneratingColor():
return generatingColor();case _GeneratedColor():
return generatedColor(_that.dominantColor);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  generatingColor,TResult? Function( Color? dominantColor)?  generatedColor,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GeneratingColor() when generatingColor != null:
return generatingColor();case _GeneratedColor() when generatedColor != null:
return generatedColor(_that.dominantColor);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DominantColorState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DominantColorState.initial()';
}


}




/// @nodoc


class _GeneratingColor implements DominantColorState {
  const _GeneratingColor();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratingColor);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DominantColorState.generatingColor()';
}


}




/// @nodoc


class _GeneratedColor implements DominantColorState {
  const _GeneratedColor({this.dominantColor});
  

 final  Color? dominantColor;

/// Create a copy of DominantColorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeneratedColorCopyWith<_GeneratedColor> get copyWith => __$GeneratedColorCopyWithImpl<_GeneratedColor>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GeneratedColor&&(identical(other.dominantColor, dominantColor) || other.dominantColor == dominantColor));
}


@override
int get hashCode => Object.hash(runtimeType,dominantColor);

@override
String toString() {
  return 'DominantColorState.generatedColor(dominantColor: $dominantColor)';
}


}

/// @nodoc
abstract mixin class _$GeneratedColorCopyWith<$Res> implements $DominantColorStateCopyWith<$Res> {
  factory _$GeneratedColorCopyWith(_GeneratedColor value, $Res Function(_GeneratedColor) _then) = __$GeneratedColorCopyWithImpl;
@useResult
$Res call({
 Color? dominantColor
});




}
/// @nodoc
class __$GeneratedColorCopyWithImpl<$Res>
    implements _$GeneratedColorCopyWith<$Res> {
  __$GeneratedColorCopyWithImpl(this._self, this._then);

  final _GeneratedColor _self;
  final $Res Function(_GeneratedColor) _then;

/// Create a copy of DominantColorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dominantColor = freezed,}) {
  return _then(_GeneratedColor(
dominantColor: freezed == dominantColor ? _self.dominantColor : dominantColor // ignore: cast_nullable_to_non_nullable
as Color?,
  ));
}


}

// dart format on
