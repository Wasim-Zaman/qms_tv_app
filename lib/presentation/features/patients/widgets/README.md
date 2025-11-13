# TV Display Screen - Responsive Architecture

## Overview
This document describes the refactored TV Display Screen with responsive design supporting both mobile and desktop (Android TV) layouts.

## Directory Structure
```
lib/presentation/features/patients/
├── models/
│   └── patient_model.dart
├── provider/
│   └── patients_provider.dart
├── view/
│   ├── tv_display_screen.dart (original - deprecated)
│   ├── tv_display_screen_new.dart
│   └── tv_display_screen_responsive.dart (NEW - recommended)
└── widgets/
    ├── display_header.dart
    ├── display_footer.dart
    ├── patient_card.dart
    ├── patients_list.dart
    └── display_states.dart
```

## Widgets Description

### 1. `display_header.dart`
**Purpose**: Header component with logo, title, time, and user info

**Components**:
- `DisplayHeader`: Main header widget
- `LiveTimeWidget`: Real-time clock display
- `UserInfoWidget`: User profile with logout option

**Responsive Features**:
- Desktop: Full horizontal layout with all elements
- Mobile: Compact two-row layout with condensed elements

### 2. `display_footer.dart`
**Purpose**: Footer with refresh status and date

**Responsive Features**:
- Desktop: Full date format (EEEE, MMMM d, y)
- Mobile: Abbreviated date format (MMM d, yyyy)

### 3. `patient_card.dart`
**Purpose**: Individual patient display cards

**Components**:
- `PatientCardDesktop`: Horizontal table row layout for TV/Desktop
- `PatientCardMobile`: Vertical card layout for mobile

**Desktop Layout**:
- Table-style row with all fields inline
- Compact, information-dense design
- Ideal for large screens

**Mobile Layout**:
- Card-based vertical layout
- Large touch targets
- Prominent ticket number and status
- Expandable information sections

### 4. `patients_list.dart`
**Purpose**: Container for patient cards

**Components**:
- `PatientsListDesktop`: Table with header row
- `PatientsListMobile`: Scrollable card list

### 5. `display_states.dart`
**Purpose**: Loading, empty, and error states

**Components**:
- `EmptyStateWidget`: No patients message
- `LoadingStateWidget`: Loading spinner
- `ErrorStateWidget`: Error display with retry button

## Responsive Breakpoint

```dart
static const double mobileBreakpoint = 600;
```

- **Width < 600px**: Mobile layout
- **Width >= 600px**: Desktop/TV layout

## Key Features

### Desktop/TV Layout
- **Optimized for**: Android TV, large displays
- **Design**: Table-based, horizontal rows
- **Information Density**: High
- **Interaction**: Remote/keyboard navigation friendly
- **Font Sizes**: Larger for viewing from distance

### Mobile Layout
- **Optimized for**: Smartphones, tablets
- **Design**: Card-based, vertical stacking
- **Information Density**: Medium
- **Interaction**: Touch-friendly
- **Font Sizes**: Standard mobile sizes

## Color Scheme
All colors use `AppColors` constants from `app_colors.dart`:
- Primary: `kPrimaryColor`
- Background: `kDarkBackgroundColor`, `kDarkSurfaceColor`
- Text: `kTextOnPrimaryColor`, `kDarkTextSecondaryColor`, `kDarkTextTertiaryColor`
- Status: `kSuccessColor`, `kErrorColor`, `kWarningColor`

## Usage

Replace the old screen import with:
```dart
import 'package:qms_tv_app/presentation/features/patients/view/tv_display_screen_responsive.dart';
```

The screen automatically adapts based on device width using `LayoutBuilder`.

## Benefits

1. **Maintainability**: Each widget is isolated and testable
2. **Reusability**: Widgets can be used in other contexts
3. **Responsive**: Single codebase for all screen sizes
4. **Performance**: Efficient widget tree with proper separation
5. **Consistency**: Uses centralized color constants
6. **Scalability**: Easy to add new features or modify existing ones

## Migration Guide

### Old Code (tv_display_screen.dart)
```dart
// All logic in one file
// Hardcoded layouts
// No responsive design
```

### New Code (tv_display_screen_responsive.dart)
```dart
// Modular widgets
// Responsive layouts
// Proper separation of concerns
```

To migrate:
1. Replace screen import
2. Test on both mobile and TV devices
3. Verify all features work correctly
4. Remove old file after verification

## Testing Recommendations

1. **Mobile Devices**: Test on phones with different screen sizes
2. **Tablets**: Verify breakpoint behavior
3. **Android TV**: Test remote navigation and readability
4. **Orientation**: Test both portrait and landscape
5. **Performance**: Monitor frame rates with many patients

## Future Enhancements

- [ ] Add animation for new patient entries
- [ ] Implement pull-to-refresh on mobile
- [ ] Add filtering/sorting capabilities
- [ ] Support for landscape tablet layout (separate from mobile/desktop)
- [ ] Voice navigation for Android TV
- [ ] Accessibility improvements (screen reader support)
