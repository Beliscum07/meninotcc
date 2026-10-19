# Basic Usage

```dart
ExampleConnector.instance.RegisterDonorProfile(registerDonorProfileVariables).execute();
ExampleConnector.instance.UpdateMyProfile(updateMyProfileVariables).execute();
ExampleConnector.instance.AdminCreateStudent(adminCreateStudentVariables).execute();
ExampleConnector.instance.AdminUpdateStudent(adminUpdateStudentVariables).execute();
ExampleConnector.instance.AdminLinkStudentAccount(adminLinkStudentAccountVariables).execute();
ExampleConnector.instance.AdminSetStudentStatus(adminSetStudentStatusVariables).execute();
ExampleConnector.instance.AdminCreateActivity(adminCreateActivityVariables).execute();
ExampleConnector.instance.AdminUpdateActivity(adminUpdateActivityVariables).execute();
ExampleConnector.instance.AdminAssignActivity(adminAssignActivityVariables).execute();
ExampleConnector.instance.AdminCreateScholarship(adminCreateScholarshipVariables).execute();

```

## Optional Fields

Some operations may have optional fields. In these cases, the Flutter SDK exposes a builder method, and will have to be set separately.

Optional fields can be discovered based on classes that have `Optional` object types.

This is an example of a mutation with an optional field:

```dart
await ExampleConnector.instance.RegisterMyDonation({ ... })
.metodo(...)
.execute();
```

Note: the above example is a mutation, but the same logic applies to query operations as well. Additionally, `createMovie` is an example, and may not be available to the user.

