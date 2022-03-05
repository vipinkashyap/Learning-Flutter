# flutter_firebase_bloc_notes

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Questions

- What are entities ?
This is coming from Felix who is the maintainer of the bloc library. He says Entities represent the raw data and are exported by the data layer. The data layer should only know/operate on entities

From Marcus NG, creator of the course
Having an entity model relationship is incredibly useful for abstracting data in the app. User entity is a representation of how the user is in the database. We can swap backends(Firestore to mongodb/aws) and we only have to make changes to the entity and not touch anything else

In this app there are some advantages of using an Entity, Model relationship to represent data
In the NoteEntity we see that the timestamp is coming from cloud firestore and in the Note model we've used a dart friendly DateTime type


## Good things

- Using barrel files is a great way to reduce import statements in every file
- 
