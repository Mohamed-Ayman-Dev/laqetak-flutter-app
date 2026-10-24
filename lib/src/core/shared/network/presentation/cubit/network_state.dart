enum NetworkStatus {
  connected,
  disconnected,
}

class NetworkState {
  final NetworkStatus status;
  final bool wasDisconnected;
  final bool justRestored;

  const NetworkState({
    this.status = NetworkStatus.connected,
    this.wasDisconnected = false,
    this.justRestored = false,
  });

  bool get isConnected => status == NetworkStatus.connected;
  bool get isDisconnected => status == NetworkStatus.disconnected;

  NetworkState copyWith({
    NetworkStatus? status,
    bool? wasDisconnected,
    bool? justRestored,
  }) {
    return NetworkState(
      status: status ?? this.status,
      wasDisconnected: wasDisconnected ?? this.wasDisconnected,
      justRestored: justRestored ?? this.justRestored,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkState &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          wasDisconnected == other.wasDisconnected &&
          justRestored == other.justRestored;

  @override
  int get hashCode =>
      status.hashCode ^ wasDisconnected.hashCode ^ justRestored.hashCode;
}
