import 'package:flutter/material.dart';
import 'package:movieproject/core/widgets/button_widget.dart';
import 'package:movieproject/product/constant/icon.dart';
import 'package:movieproject/product/constant/padding.dart';
import 'package:movieproject/product/utils/utils.dart';
import 'package:movieproject/product/widgets/textformfield_widget.dart';
import 'package:movieproject/resources/auth_method.dart';
import 'package:movieproject/screens/splashScreen_page_view.dart';

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}
TextEditingController _emailController=TextEditingController();
TextEditingController _passwordController=TextEditingController();
TextEditingController _nameController=TextEditingController();
bool _isLoading = false;

class _LoginPageViewState extends State<LoginPageView> {


     void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
       );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LottieAnimation()
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      showSnackBar(context, res);
    }
  }











  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("NETFLIX",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 25),),
        ),
        backgroundColor:(Colors.grey.shade900),
        body: Padding(
          padding: ProjectPadding().mainPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormFieldWidget(controller: _nameController, hintText: 'E-posta', icon: ProjectIcon().emailIcon, isPasswordField: false, size: size, type: TextInputType.emailAddress, visible: false,),
              SizedBox(height: size.height*0.03,),
              TextFormFieldWidget(controller: _emailController, hintText: 'E-posta', icon: ProjectIcon().emailIcon, isPasswordField: false, size: size, type: TextInputType.emailAddress, visible: false,),
              SizedBox(height: size.height*0.03,),
              TextFormFieldWidget(controller: _passwordController, hintText: 'Şifre', icon: ProjectIcon().passwordIcon, isPasswordField: true, size: size, type: TextInputType.text, visible: true,),
              SizedBox(height: size.height*0.04,),
              !_isLoading ? ButtonWidget(onPressed: signUpUser, buttonText: "Oturum Aç", size: size/1, backgroundColor: Colors.transparent,):
              ButtonWidget(onPressed: (){}, buttonText: "LÜTFEN BEKLEYİN", size: size/1, backgroundColor: Colors.transparent,),
              SizedBox(height: size.height*0.02,),
              ButtonWidget(onPressed: (){}, buttonText: "Parolayı Kurtar", size: size/1, backgroundColor: Colors.transparent,),
              SizedBox(height: size.height*0.04,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Text("Oturum açma işlemi, robot olmadığınızı kanıtlamak için Google reCAPTCHA ile korunuyor.",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white),textAlign: TextAlign.center,),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}