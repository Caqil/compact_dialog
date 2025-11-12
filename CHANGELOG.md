## 0.0.1

* Initial release of CompactDialog with shadcn/ui inspired design
* **shadcn/ui Design System**:
  * Authentic shadcn/ui color palette (slate colors for light/dark modes)
  * Proper button variants (filled primary, outline secondary, destructive)
  * Ring focus states on inputs
  * Subtle shadows and borders matching shadcn/ui aesthetic
  * Typography with proper letter spacing and font weights
  * Consistent 6px border radius for buttons and inputs, 12px for dialogs
* Pre-built dialog types:
  * Success dialog (green check icon)
  * Error dialog (red error icon)
  * Warning dialog (amber warning icon)
  * Info dialog (blue info icon)
  * Destructive dialog (red button variant for dangerous actions)
* Extended features:
  * Loading dialog with circular progress indicator
  * Input dialog with validation support and ring focus states
  * Multiline input support
  * Confirmation dialog with optional checkbox
  * Progress dialog with stream-based updates
  * Custom content dialog for maximum flexibility
* Theme system:
  * Extended DialogColorScheme with primary/primaryForeground, secondary/secondaryForeground, destructive/destructiveForeground, ring, input, accent colors
  * CompactDialogTheme with full customization (button height, input height, border radius)
  * Automatic Material theme adaptation
  * Light and dark mode support matching shadcn/ui palettes
* Beautiful animations:
  * Scale transition with easeOutBack curve
  * Fade transition
  * Smooth 200ms duration
* Built without external dependencies (pure Flutter, no shadcn_ui package required)
* Comprehensive example app demonstrating all features
* Full documentation with usage examples
* ✅ All tests passing
* ✅ Flutter analyze: No issues found
