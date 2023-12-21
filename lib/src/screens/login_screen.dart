import 'package:distribution/global.dart';
import 'package:distribution/routes.dart';
import 'package:distribution/src/constants/color_constants.dart';
import 'package:distribution/src/providers/bottom_provider.dart';
import 'package:distribution/src/utils/loading.dart';
import 'package:distribution/src/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final storage = FlutterSecureStorage();
  TextEditingController userid = TextEditingController(text: '');
  FocusNode _userIDFocusNode = FocusNode();
  Color _userIDBorderColor = ColorConstants.borderColor;

  TextEditingController password = TextEditingController(text: '');
  FocusNode _passwordFocusNode = FocusNode();
  Color _passwordBorderColor = ColorConstants.borderColor;
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _userIDFocusNode.addListener(() {
      setState(() {
        _userIDBorderColor = _userIDFocusNode.hasFocus
            ? Theme.of(context).primaryColor
            : ColorConstants.borderColor;
      });
    });
    _passwordFocusNode.addListener(() {
      setState(() {
        _passwordBorderColor = _passwordFocusNode.hasFocus
            ? Theme.of(context).primaryColor
            : ColorConstants.borderColor;
      });
    });
  }

  @override
  void dispose() {
    _userIDFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _handleSubmitted(String value) {
    if (value.isNotEmpty) {
      showLoadingDialog(context);
      login();
    }
  }

  login() async {
    BottomProvider bottomProvider =
        Provider.of<BottomProvider>(context, listen: false);
    bottomProvider.selectIndex(1);
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.dashboard,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _userIDFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: ColorConstants.fillColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 64,
                  bottom: 4,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome back!",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's get you logged in and ready to go.",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _userIDBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: userid,
                  focusNode: _userIDFocusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: Theme.of(context).textTheme.bodyLarge,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: language["User Name"] ?? "User Name",
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    border: InputBorder.none,
                    prefixIcon: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(
                        "assets/icons/person.svg",
                        colorFilter: ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 32,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _passwordBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: password,
                  focusNode: _passwordFocusNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: obscurePassword,
                  style: Theme.of(context).textTheme.bodyLarge,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: language["Password"] ?? "Password",
                    labelStyle: Theme.of(context).textTheme.labelSmall,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    border: InputBorder.none,
                    prefixIcon: IconButton(
                      onPressed: null,
                      icon: SvgPicture.asset(
                        "assets/icons/lock.svg",
                        colorFilter: ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: SvgPicture.asset(
                        obscurePassword
                            ? "assets/icons/eye-close.svg"
                            : "assets/icons/eye.svg",
                        colorFilter: ColorFilter.mode(
                          Colors.grey,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  onFieldSubmitted: _handleSubmitted,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 24,
                ),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    if (userid.text.isEmpty) {
                      ToastUtil.showToast(
                          0, language["Enter User Name"] ?? "Enter User Name");
                      return;
                    }
                    if (password.text.isEmpty) {
                      ToastUtil.showToast(
                          0, language["Enter Password"] ?? "Enter Password");
                      return;
                    }
                    showLoadingDialog(context);
                    login();
                  },
                  child: Text(
                    language["Log In"] ?? "Log In",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
