// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'random_image_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RandomImageState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RandomImageState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RandomImageState()';
}


}

/// @nodoc
class $RandomImageStateCopyWith<$Res>  {
$RandomImageStateCopyWith(RandomImageState _, $Res Function(RandomImageState) __);
}


/// Adds pattern-matching-related methods to [RandomImageState].
extension RandomImageStatePatterns on RandomImageState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _GettingImage value)?  gettingImage,TResult Function( _GotImage value)?  gotImage,TResult Function( _FailedToGetImage value)?  failedToGetImage,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GettingImage() when gettingImage != null:
return gettingImage(_that);case _GotImage() when gotImage != null:
return gotImage(_that);case _FailedToGetImage() when failedToGetImage != null:
return failedToGetImage(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _GettingImage value)  gettingImage,required TResult Function( _GotImage value)  gotImage,required TResult Function( _FailedToGetImage value)  failedToGetImage,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _GettingImage():
return gettingImage(_that);case _GotImage():
return gotImage(_that);case _FailedToGetImage():
return failedToGetImage(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _GettingImage value)?  gettingImage,TResult? Function( _GotImage value)?  gotImage,TResult? Function( _FailedToGetImage value)?  failedToGetImage,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _GettingImage() when gettingImage != null:
return gettingImage(_that);case _GotImage() when gotImage != null:
return gotImage(_that);case _FailedToGetImage() when failedToGetImage != null:
return failedToGetImage(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  gettingImage,TResult Function( ImageModel image)?  gotImage,TResult Function( String message)?  failedToGetImage,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GettingImage() when gettingImage != null:
return gettingImage();case _GotImage() when gotImage != null:
return gotImage(_that.image);case _FailedToGetImage() when failedToGetImage != null:
return failedToGetImage(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  gettingImage,required TResult Function( ImageModel image)  gotImage,required TResult Function( String message)  failedToGetImage,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _GettingImage():
return gettingImage();case _GotImage():
return gotImage(_that.image);case _FailedToGetImage():
return failedToGetImage(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  gettingImage,TResult? Function( ImageModel image)?  gotImage,TResult? Function( String message)?  failedToGetImage,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _GettingImage() when gettingImage != null:
return gettingImage();case _GotImage() when gotImage != null:
return gotImage(_that.image);case _FailedToGetImage() when failedToGetImage != null:
return failedToGetImage(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements RandomImageState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RandomImageState.initial()';
}


}




/// @nodoc


class _GettingImage implements RandomImageState {
  const _GettingImage();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GettingImage);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RandomImageState.gettingImage()';
}


}




/// @nodoc


class _GotImage implements RandomImageState {
  const _GotImage({required this.image});
  

 final  ImageModel image;

/// Create a copy of RandomImageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GotImageCopyWith<_GotImage> get copyWith => __$GotImageCopyWithImpl<_GotImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GotImage&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,image);

@override
String toString() {
  return 'RandomImageState.gotImage(image: $image)';
}


}

/// @nodoc
abstract mixin class _$GotImageCopyWith<$Res> implements $RandomImageStateCopyWith<$Res> {
  factory _$GotImageCopyWith(_GotImage value, $Res Function(_GotImage) _then) = __$GotImageCopyWithImpl;
@useResult
$Res call({
 ImageModel image
});




}
/// @nodoc
class __$GotImageCopyWithImpl<$Res>
    implements _$GotImageCopyWith<$Res> {
  __$GotImageCopyWithImpl(this._self, this._then);

  final _GotImage _self;
  final $Res Function(_GotImage) _then;

/// Create a copy of RandomImageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? image = null,}) {
  return _then(_GotImage(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as ImageModel,
  ));
}


}

/// @nodoc


class _FailedToGetImage implements RandomImageState {
  const _FailedToGetImage({required this.message});
  

 final  String message;

/// Create a copy of RandomImageState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FailedToGetImageCopyWith<_FailedToGetImage> get copyWith => __$FailedToGetImageCopyWithImpl<_FailedToGetImage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FailedToGetImage&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RandomImageState.failedToGetImage(message: $message)';
}


}

/// @nodoc
abstract mixin class _$FailedToGetImageCopyWith<$Res> implements $RandomImageStateCopyWith<$Res> {
  factory _$FailedToGetImageCopyWith(_FailedToGetImage value, $Res Function(_FailedToGetImage) _then) = __$FailedToGetImageCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$FailedToGetImageCopyWithImpl<$Res>
    implements _$FailedToGetImageCopyWith<$Res> {
  __$FailedToGetImageCopyWithImpl(this._self, this._then);

  final _FailedToGetImage _self;
  final $Res Function(_FailedToGetImage) _then;

/// Create a copy of RandomImageState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_FailedToGetImage(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
