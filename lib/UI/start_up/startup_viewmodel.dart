import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../router/app.router.dart';
import '/services/authentication_service.dart';
import '../../locator.dart';

class StartUpViewmodel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> handleStartUpLogic() async {
    await Future.delayed(const Duration(seconds: 1));
    bool isUserLoggedIn = await _authenticationService.isUserLoggedIn();
    if (isUserLoggedIn) {
      _navigationService.navigateTo(
        Routes.homeView,
        arguments: HomeViewArguments(index: 0),
      );
    } else {
      _navigationService.navigateTo(Routes.signInView);
    }
  }
}
