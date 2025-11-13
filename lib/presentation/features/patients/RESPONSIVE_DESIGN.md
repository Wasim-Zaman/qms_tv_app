# Responsive Design Comparison

## Mobile Layout (< 600px width)

### Header
```
┌─────────────────────────────────────────┐
│ [🏥] Queue Management      [👤]         │
│      Patient Display                    │
│ ⏰ 14:30:45          🔄 Live           │
└─────────────────────────────────────────┘
```

### Patient Card
```
┌─────────────────────────────────────────┐
│ [🎫 #123]               [⚠️ Urgent]    │
│                                         │
│ John Smith                              │
│                                         │
│ 👤 MRN: MRN12345                       │
│ 🏥 Department: Cardiology              │
│ ⏰ Called At: 14:25                    │
└─────────────────────────────────────────┘
```

### Footer
```
┌─────────────────────────────────────────┐
│ [🔄 Auto-refresh: 10s]  Nov 13, 2025   │
└─────────────────────────────────────────┘
```

---

## Desktop/TV Layout (>= 600px width)

### Header
```
┌──────────────────────────────────────────────────────────────────────────┐
│ [🏥] Hospital Queue Management              ⏰ 14:30:45  [👤 John Doe ▼] │
│      Called Patients Display                                             │
└──────────────────────────────────────────────────────────────────────────┘
```

### Patient Table
```
┌──────────────────────────────────────────────────────────────────────────┐
│ # | Ticket No. | Patient Name | Department  | Status  | Call Time       │
├──────────────────────────────────────────────────────────────────────────┤
│ 1 │ [#123]     │ John Smith   │ Cardiology  │ ⚠️ Urgent│ ⏰ 14:25        │
│   │            │ MRN: MRN123  │             │         │                 │
├──────────────────────────────────────────────────────────────────────────┤
│ 2 │ [#124]     │ Jane Doe     │ Neurology   │ ✅ Normal│ ⏰ 14:27        │
│   │            │ MRN: MRN124  │             │         │                 │
└──────────────────────────────────────────────────────────────────────────┘
```

### Footer
```
┌──────────────────────────────────────────────────────────────────────────┐
│ [🔄 Auto-refresh: 10s]              Wednesday, November 13, 2025         │
└──────────────────────────────────────────────────────────────────────────┘
```

---

## Key Differences

| Feature | Mobile | Desktop/TV |
|---------|--------|------------|
| **Layout** | Vertical cards | Horizontal table |
| **Header** | 2 rows, compact | 1 row, full |
| **Patient Info** | Stacked vertically | Row format |
| **Date Format** | Short (Nov 13, 2025) | Full (Wednesday, November 13, 2025) |
| **Font Sizes** | Standard mobile | Larger for distance viewing |
| **Navigation** | Touch-friendly | Remote/keyboard friendly |
| **Info Density** | Medium | High |
| **Ticket Display** | Prominent badge | Inline with icon |
| **Status Badge** | Pill-shaped | Inline with icon |

---

## Adaptive Elements

### DisplayHeader Widget
- **Mobile**: Compact 2-row layout, smaller icons (24px vs 32px)
- **Desktop**: Full single-row layout, larger elements

### LiveTimeWidget
- **Mobile**: 14px font, compact padding
- **Desktop**: 16px font, standard padding

### UserInfoWidget
- **Mobile**: Icon only (compact mode)
- **Desktop**: Icon + name + dropdown

### Patient Cards
- **Mobile**: `PatientCardMobile` - Vertical card with sections
- **Desktop**: `PatientCardDesktop` - Horizontal table row

### DisplayFooter
- **Mobile**: Shorter date, smaller refresh indicator
- **Desktop**: Full date format, standard sizing

---

## Breakpoint Logic

```dart
LayoutBuilder(
  builder: (context, constraints) {
    final isMobile = constraints.maxWidth < 600;
    return isMobile 
      ? MobileLayout() 
      : DesktopLayout();
  },
)
```

---

## Use Cases

### Mobile (Phone/Small Tablet)
- ✅ Healthcare staff checking on the go
- ✅ Patients checking their status
- ✅ Quick status updates
- ✅ Portrait orientation preferred

### Desktop/TV (Android TV/Large Displays)
- ✅ Waiting room displays
- ✅ Reception area monitors
- ✅ Department status boards
- ✅ Multiple patients visible at once
- ✅ Viewable from distance

---

## Responsive Features

1. **Automatic Detection**: Uses `LayoutBuilder` to detect screen size
2. **Optimized Layouts**: Completely different UI for each form factor
3. **Consistent Data**: Same data, different presentation
4. **Smooth Transitions**: No jarring layout shifts
5. **Accessibility**: Touch and remote navigation support
6. **Performance**: Optimized widget trees for each layout

---

## Testing Scenarios

### Mobile Testing
- [ ] Portrait mode (320px - 600px width)
- [ ] Small phones (320px - 375px)
- [ ] Standard phones (375px - 414px)
- [ ] Large phones (414px - 600px)
- [ ] Touch interactions
- [ ] Pull to refresh (if implemented)

### Desktop/TV Testing
- [ ] Tablet landscape (600px - 1024px)
- [ ] Desktop (1024px - 1920px)
- [ ] 4K displays (1920px+)
- [ ] Android TV (720p, 1080p, 4K)
- [ ] Remote navigation
- [ ] Keyboard navigation
- [ ] Distance readability (10ft rule)

---

## Color Consistency

Both layouts use the same color scheme from `app_colors.dart`:

- Primary: `#2563EB` (Blue)
- Success: `#10B981` (Green)
- Error: `#EF4444` (Red)
- Warning: `#F59E0B` (Orange)
- Background: `#111827` (Dark)
- Surface: `#1F2937` (Dark Grey)

This ensures brand consistency across all devices.
