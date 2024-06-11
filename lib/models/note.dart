class NotesModel {
  final int? id;
  final String title;
  final String description;
  final int age;
  final String email;

  NotesModel(
      {this.id,
      required this.title,
      required this.age,
      required this.email,
      required this.description});

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      description = newDescription;
    }
  }

  // Extract a NotesModel object from a Map object
  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        email = res['email'],
        age = res['age'];

  // Convert a NotesModel object into a Map object
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'email': email,
      'age': age,
    };
  }
}
