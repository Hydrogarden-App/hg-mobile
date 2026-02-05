import "package:reactive_forms/reactive_forms.dart";

extension FormGroupExtension on FormGroup {
  static FormGroup loginForm({
    required String emailFieldName,
    required String passwordFieldName,
    int passwordMinLength = 1,
  }) => FormGroup({
    emailFieldName: FormControl<String>(
      validators: [Validators.required, Validators.email],
    ),
    passwordFieldName: FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(passwordMinLength),
      ],
    ),
  });

  static FormGroup registerForm({
    required String emailFieldName,
    required String passwordFieldName,
    required repeatPasswordFieldName,
    int passwordMinLength = 1,
  }) => FormGroup(
    {
      emailFieldName: FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      passwordFieldName: FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(passwordMinLength),
        ],
      ),
      repeatPasswordFieldName: FormControl<String>(
        validators: [Validators.required],
      ),
    },
    validators: [Validators.mustMatch("password", "passwordRepeat")],
  );
}
