# Login Screen Widgets

This directory contains modular, reusable widgets for the login screen. Each widget handles a specific part of the login flow.

## Widget Structure

```
widgets/
├── logo_header.dart           # Logo, title, and app branding
├── login_form_header.dart    # Welcome message and subtitle
├── email_field.dart          # Email input with validation
├── password_field.dart       # Password input with show/hide toggle
├── sign_in_button.dart       # Sign in button with loading state
├── login_form_card.dart      # Card container for the form
├── login_footer.dart         # Footer text with app info
└── widgets.dart              # Barrel export file
```

## Widgets Overview

### LogoHeader
**File:** `logo_header.dart`

Displays the app logo, title, and subtitle with gradient background.

**Features:**
- Animated icon container with shadow
- Green/Teal gradient background
- Responsive text styling using AppThemes

**Usage:**
```dart
const LogoHeader()
```

### LoginFormHeader
**File:** `login_form_header.dart`

Shows welcome message and sign-in instructions.

**Features:**
- Centered title and subtitle
- Uses AppThemes for consistent styling
- Responsive text sizes

**Usage:**
```dart
const LoginFormHeader()
```

### EmailField
**File:** `email_field.dart`

Email input field with icon and validation.

**Properties:**
- `controller`: TextEditingController
- `isLoading`: Bool to disable field during login
- `validator`: String validation function

**Features:**
- Email icon prefix
- Email keyboard type
- Form validation support

**Usage:**
```dart
EmailField(
  controller: _emailController,
  isLoading: isLoading,
  validator: validator.validateEmail,
)
```

### PasswordField
**File:** `password_field.dart`

Password input with show/hide toggle.

**Properties:**
- `controller`: TextEditingController
- `isLoading`: Bool to disable field during login
- `validator`: String validation function
- `onSubmitted`: Callback when user submits (presses Enter)

**Features:**
- Lock icon prefix
- Eye/Eye-slash icon toggle
- Password obscuring with stateful toggle
- Submit on Enter key

**Usage:**
```dart
PasswordField(
  controller: _passwordController,
  isLoading: isLoading,
  validator: validator.validatePassword,
  onSubmitted: _handleLogin,
)
```

### SignInButton
**File:** `sign_in_button.dart`

Sign in button with loading state.

**Properties:**
- `isLoading`: Bool to show loading indicator
- `onPressed`: VoidCallback when button pressed

**Features:**
- Login icon
- Loading spinner animation
- Auto-disable when loading

**Usage:**
```dart
SignInButton(
  isLoading: isLoading,
  onPressed: _handleLogin,
)
```

### LoginFormCard
**File:** `login_form_card.dart`

Container for the login form with card styling.

**Properties:**
- `child`: Widget to display inside card

**Features:**
- White background
- Rounded corners (16px)
- Shadow effect

**Usage:**
```dart
LoginFormCard(
  child: Column(
    children: [
      LoginFormHeader(),
      // ... form fields
    ],
  ),
)
```

### LoginFooter
**File:** `login_footer.dart`

Footer text with app description.

**Features:**
- Tertiary text color
- Small text style from AppThemes
- Centered alignment

**Usage:**
```dart
const LoginFooter()
```

## Design System

All widgets use the following constants:

### Colors (from `app_colors.dart`)
- **Primary:** Green (#10B981)
- **Secondary:** Teal (#14B8A6)
- **Text Primary:** #111827
- **Text Secondary:** #6B7280
- **Text Tertiary:** #9CA3AF
- **Icon Secondary:** #6B7280

### Typography (from `app_themes.dart`)
- **Headline Medium:** 24px, Bold
- **Title Large:** 20px, Bold
- **Body Large:** 16px
- **Body Medium:** 14px
- **Body Small:** 12px

## Integration with LoginScreen

The main `login_screen.dart` orchestrates these widgets:

```dart
class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const LogoHeader(),
                  48.heightBox,
                  LoginFormCard(
                    child: Column(
                      children: [
                        const LoginFormHeader(),
                        32.heightBox,
                        EmailField(...),
                        20.heightBox,
                        PasswordField(...),
                        32.heightBox,
                        SignInButton(...),
                      ],
                    ),
                  ),
                  24.heightBox,
                  const LoginFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

## State Management

- **Form Key:** Manages form validation
- **Email/Password Controllers:** Capture user input
- **Animation Controllers:** Fade and slide animations
- **Riverpod Providers:** Handle login state and validation

## Best Practices

1. **Use only AppColors and AppThemes** - No hardcoded colors
2. **Keep widgets focused** - Each widget has a single responsibility
3. **Use const constructors** - For better performance
4. **Leverage extensions** - Use `heightBox` and `widthBox` for spacing
5. **Proper validator injection** - Pass validators from parent

## Future Enhancements

- [ ] Add "Remember Me" checkbox
- [ ] Implement "Forgot Password" link
- [ ] Add social login options
- [ ] Add password strength indicator
- [ ] Implement biometric login fallback
- [ ] Add internationalization (i18n) support

## Related Files

- **Parent Screen:** `/lib/presentation/features/auth/view/login_screen.dart`
- **Providers:** `/lib/presentation/features/auth/provider/`
- **Constants:** `/lib/core/constants/app_colors.dart`, `app_themes.dart`
- **Extensions:** `/lib/core/extensions/sizedbox_extension.dart`
