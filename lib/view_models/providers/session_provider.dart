import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/session_api.dart';
import '../../models/session.dart';
import '../../models/system_models.dart';

class SessionProvider extends ChangeNotifier {
  bool _loading = false;
  Session? _session;
  SessionError? _sessionError;

  bool get loading => _loading;

  Session? get session => _session;

  SessionError? get sessionError => _sessionError;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setSession(Session session) {
    _session = session;
  }

  setSessionError(SessionError sessionError) {
    _sessionError = sessionError;
  }

  Future<bool> createSession(String userName, String password) async {
    setLoading(true);
    var response = await SessionApi.postSession(userName, password);
    if (response is Success) {
      setSession(response.response as Session);
      setLoading(false);
      return true;
    }
    if (response is Failure) {
      SessionError sessionError = SessionError(
        code: response.code,
        message: response.errorResponse,
      );
      setSessionError(sessionError);

      setLoading(false);
      return false;
    }
    return false;
  }

  Future<bool> refreshSession(String accessToken) async {
    setLoading(true);
    var response = await SessionApi.refreshSession(accessToken);
    if (response is Success) {
      setSession(response.response as Session);
      // SharedPreferences prefs = await preferences;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', _session!.accessToken);
      prefs.setString('refreshToken', _session!.refreshToken);
      setLoading(false);

      return true;
    }
    if (response is Failure) {
      SessionError sessionError = SessionError(
        code: response.code,
        message: response.errorResponse,
      );
      setSessionError(sessionError);
      setLoading(false);
      return false;
    }
    return false;
  }

  Future<bool> getPreviousSession(String accessToken) async {
    setLoading(true);
    var response = await SessionApi.getPreviousSession(accessToken);
    if (response is Success) {
      setSession(response.response as Session);
      setLoading(false);
      return true;
    }
    if (response is Failure) {
      SessionError sessionError = SessionError(
        code: response.code,
        message: response.errorResponse,
      );
      setSessionError(sessionError);
      // setSessionError(sessionError as SessionError);
      // sessionError.showErrorMessage();
      setLoading(false);
      return false;
    }
    return false;
  }
}
