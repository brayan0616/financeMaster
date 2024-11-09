import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_shop/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';
import 'package:teslo_shop/features/shared/shared.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground( 
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox( height: 30 ),
                // Icon Banner
                Image.asset('assets/images/financeMaster.png', height: 220),
                const SizedBox( height: 70 ),
    
                Container(
                  height: size.height - 260, // 80 los dos sizebox y 100 el ícono
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: const _LoginForm(),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {

  const _LoginForm();

  void showSnackbar( BuildContext context, String message ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final loginForm = ref.watch(loginFormProvider);
    final colors = Theme.of(context).colorScheme;

    ref.listen(authProvider, (previous, next) {
      if ( next.errorMessage.isEmpty ) return;
      showSnackbar( context, next.errorMessage );
    });


    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox( height: 50 ),
          Text('Login', style: textStyles.titleLarge?.copyWith(color: colors.primary) ),
          const SizedBox( height: 90 ),

          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errorMessage: loginForm.isFormPosted ?
               loginForm.email.errorMessage 
               : null,
          ),
          const SizedBox( height: 30 ),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: loginForm.obsecureText,
            suffixIcon: IconButton(
              icon:  loginForm.obsecureText ? const Icon( Icons.remove_red_eye_outlined ):
                const Icon( Icons.visibility_off_outlined ),
              onPressed: (){
                ref.read(loginFormProvider.notifier).onObsecureText();
              },
              // padding: const EdgeInsets.only(right: 10),
            ),
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            errorMessage: loginForm.isFormPosted ?
               loginForm.password.errorMessage 
               : null,
          ),
    
          const SizedBox( height: 30 ),

          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: loginForm.isPosting ? '' : 'Ingresar',
              // buttonColor: Colors.black,
              onPressed: loginForm.isPosting
                ? null 
                : ref.read(loginFormProvider.notifier).onFormSubmit,
              child: loginForm.isPosting ? const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
              ) : null,
            )
          ),

          const Spacer( flex: 2 ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                onPressed: ()=> context.push('/register'), 
                child: const Text('Crea una aquí')
              )
            ],
          ),

          const Spacer( flex: 1),
        ],
      ),
    );
  }
}