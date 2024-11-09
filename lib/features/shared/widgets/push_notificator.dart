import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PushNotificator extends ConsumerStatefulWidget {

  
  final double? data;
  final String title;
  final String? content;
  final String? simbolo;

  const PushNotificator({
    super.key,
    this.data,
    required this.title,
    this.content,
    this.simbolo = '',
  });

  @override
  ConsumerState<PushNotificator> createState() => PushNotificatorState();
}

class PushNotificatorState extends ConsumerState<PushNotificator> {


  bool _isVisble = true;

  void _closeDialog() {
    setState(() {
      _isVisble = false;
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      Navigator.of(context).pop();
    });
  }





  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;


    return _isVisble
    ? ZoomIn(
      duration: const Duration(milliseconds: 1200),
      child: AlertDialog(
        title: Text(widget.title, style: textStyle.titleSmall?.copyWith(color: colors.primary, fontSize: 20,fontWeight: FontWeight.bold),),
        content: Text('${widget.content ?? 'resultado: '}${widget.data?.toStringAsFixed(1) ?? '' }${widget.simbolo}', style: textStyle.titleSmall?.copyWith(color: colors.secondary, fontSize: 16),),
        actions: [
          FilledButton(
            onPressed: _closeDialog,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(colors.primary.withOpacity(0.8)),
              shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                ))
              )
            ),
            child: Text('Aceptar', style: textStyle.titleSmall?.copyWith( fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),)
          )
        ],
      ),
    ): ZoomOut(
        child: AlertDialog(
          title: Text(widget.title, style: textStyle.titleSmall?.copyWith(color: colors.primary, fontSize: 20,fontWeight: FontWeight.bold),),
          content: Text('${widget.content ?? 'resultado: '}${widget.data?.toStringAsFixed(1) ?? ''}${widget.simbolo}', style: textStyle.titleSmall?.copyWith(color: colors.secondary, fontSize: 16),),
          actions: [
            FilledButton(
              onPressed: _closeDialog,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(colors.primary.withOpacity(0.8)),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder(borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  ))
                )
              ),
              child: Text('Aceptar', style: textStyle.titleSmall?.copyWith( fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),)
            )
          ],
        ),
      );
  }
}

