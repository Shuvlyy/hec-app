class Doctor {
  final String id;
  final String name;
  final String specialty;
  final String workplace;
  final String? profileImageUrl;

  Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.workplace,
    this.profileImageUrl,
  });
}
