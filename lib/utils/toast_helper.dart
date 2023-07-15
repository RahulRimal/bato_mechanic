import 'package:bato_mechanic/utils/system_helper.dart';
import 'package:bato_mechanic/view_models/providers/mechanic_provider.dart';
import 'package:bato_mechanic/view_models/providers/system_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToastHelper {
  static showLoading(BuildContext ctx) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'showLoading dismissed',
      context: ctx,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.amberAccent[200],
            // contentPadding: EdgeInsets.symmetric(
            //   horizontal: 0,
            //   vertical: 15,
            // ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              // width: 10,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  const SizedBox(height: 10),
                  if (Provider.of<SystemProvider>(ctx).loadingMessage != null)
                    Text(
                      Provider.of<SystemProvider>(ctx)
                          .loadingMessage
                          .toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static showNotification(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.amberAccent[700],
      dismissDirection: DismissDirection.horizontal,
      content: Text(
        message.toCapitalize(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 3),
    ));
  }
}