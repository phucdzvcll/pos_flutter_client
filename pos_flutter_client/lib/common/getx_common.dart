import 'package:get/get.dart';

// class GetXCommonBuilder<T extends DisposableInterface> extends GetX<T> {
//   final String? tag;
//   final bool global;
//   final GetXControllerBuilder<T> builder;
//   final void Function(GetXState<T> state)? initState,
//       dispose,
//       didChangeDependencies;
//   final void Function(GetX oldWidget, GetXState<T> state)? didUpdateWidget;
//   final T? init;
//
//   GetXCommonBuilder({
//     required this.builder,
//     this.global: false,
//     this.initState,
//     this.dispose,
//     this.didChangeDependencies,
//     this.didUpdateWidget,
//     this.init,
//     this.tag,
//   }) : super(
//           builder: builder,
//           tag: tag,
//           global: false,
//           autoRemove: true,
//           initState: initState,
//           assignId: false,
//           dispose: dispose,
//           didChangeDependencies: didChangeDependencies,
//           didUpdateWidget: didUpdateWidget,
//           init: init,
//         );
// }

class GetXWrapBuilder<T extends DisposableInterface> extends GetX<T> {
  GetXWrapBuilder({
    required GetXControllerBuilder<T> builder,
    bool global: false,
    Function(GetXState<T> state)? initState,
    Function(GetXState<T> state)? dispose,
    Function(GetXState<T> state)? didChangeDependencies,
    Function(GetX oldWidget, GetXState<T> state)? didUpdateWidget,
    required T initController,
    String? tag,
  }) : super(
          builder: builder,
          tag: tag,
          global: false,
          autoRemove: true,
          initState: initState,
          assignId: false,
          dispose: dispose,
          didChangeDependencies: didChangeDependencies,
          didUpdateWidget: didUpdateWidget,
          init: initController,
        );
}
