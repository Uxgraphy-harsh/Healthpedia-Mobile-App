/// Comprehensive states for all Master Premium Inputs.
enum PremiumFieldState {
  /// Default state when not focused or hovered.
  defaultState,

  /// Active state when the user is interacting with the field.
  focused,

  /// Interactive state when mouse is over the field (Web/Desktop).
  hovered,

  /// Error state when validation fails.
  error,

  /// Success state for validated fields.
  success,

  /// State when interaction is restricted.
  disabled,

  /// State when an asynchronous operation is in progress.
  loading,
}

/// Helper extension for state-based logic.
extension PremiumFieldStateX on PremiumFieldState {
  bool get isFocused => this == PremiumFieldState.focused;
  bool get isError => this == PremiumFieldState.error;
  bool get isDisabled => this == PremiumFieldState.disabled;
  bool get isInteractive => this != PremiumFieldState.disabled;
}
