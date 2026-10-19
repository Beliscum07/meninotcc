# meninotcc_dataconnect SDK

## Installation
```sh
flutter pub get firebase_data_connect
flutterfire configure
```
For more information, see [Flutter for Firebase installation documentation](https://firebase.google.com/docs/data-connect/flutter-sdk#use-core).

## Data Connect instance
Each connector creates a static class, with an instance of the `DataConnect` class that can be used to connect to your Data Connect backend and call operations.

### Connecting to the emulator

```dart
String host = 'localhost'; // or your host name
int port = 9399; // or your port number
ExampleConnector.instance.dataConnect.useDataConnectEmulator(host, port);
```

You can also call queries and mutations by using the connector class.
## Queries

### GetMyProfile
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getMyProfile().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyProfileData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMyProfile();
GetMyProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getMyProfile().ref();
ref.execute();

ref.subscribe(...);
```


### GetMyStudent
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getMyStudent().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyStudentData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMyStudent();
GetMyStudentData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getMyStudent().ref();
ref.execute();

ref.subscribe(...);
```


### ListStudents
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listStudents().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListStudentsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listStudents();
ListStudentsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listStudents().ref();
ref.execute();

ref.subscribe(...);
```


### ListActivities
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listActivities().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListActivitiesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listActivities();
ListActivitiesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listActivities().ref();
ref.execute();

ref.subscribe(...);
```


### ListScholarships
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listScholarships().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListScholarshipsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listScholarships();
ListScholarshipsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listScholarships().ref();
ref.execute();

ref.subscribe(...);
```


### ListMyActivities
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMyActivities().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMyActivitiesData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMyActivities();
ListMyActivitiesData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMyActivities().ref();
ref.execute();

ref.subscribe(...);
```


### ListMyScholarships
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMyScholarships().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMyScholarshipsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMyScholarships();
ListMyScholarshipsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMyScholarships().ref();
ref.execute();

ref.subscribe(...);
```


### ListAgenda
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listAgenda().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListAgendaData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listAgenda();
ListAgendaData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listAgenda().ref();
ref.execute();

ref.subscribe(...);
```


### GetMyNotifications
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.getMyNotifications().execute();
```



#### Return Type
`execute()` returns a `QueryResult<GetMyNotificationsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.getMyNotifications();
GetMyNotificationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.getMyNotifications().ref();
ref.execute();

ref.subscribe(...);
```


### ListMyDonations
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listMyDonations().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListMyDonationsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listMyDonations();
ListMyDonationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listMyDonations().ref();
ref.execute();

ref.subscribe(...);
```


### ListDonations
#### Required Arguments
```dart
// No required arguments
ExampleConnector.instance.listDonations().execute();
```



#### Return Type
`execute()` returns a `QueryResult<ListDonationsData, void>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

/// Result of a query request. Created to hold extra variables in the future.
class QueryResult<Data, Variables> extends OperationResult<Data, Variables> {
  QueryResult(super.dataConnect, super.data, super.ref);
}

final result = await ExampleConnector.instance.listDonations();
ListDonationsData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
final ref = ExampleConnector.instance.listDonations().ref();
ref.execute();

ref.subscribe(...);
```

## Mutations

### RegisterDonorProfile
#### Required Arguments
```dart
String nome = ...;
String telefone = ...;
ExampleConnector.instance.registerDonorProfile(
  nome: nome,
  telefone: telefone,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<RegisterDonorProfileData, RegisterDonorProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.registerDonorProfile(
  nome: nome,
  telefone: telefone,
);
RegisterDonorProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nome = ...;
String telefone = ...;

final ref = ExampleConnector.instance.registerDonorProfile(
  nome: nome,
  telefone: telefone,
).ref();
ref.execute();
```


### UpdateMyProfile
#### Required Arguments
```dart
String nome = ...;
ExampleConnector.instance.updateMyProfile(
  nome: nome,
).execute();
```

#### Optional Arguments
We return a builder for each query. For UpdateMyProfile, we created `UpdateMyProfileBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class UpdateMyProfileVariablesBuilder {
  ...
   UpdateMyProfileVariablesBuilder telefone(String? t) {
   _telefone.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.updateMyProfile(
  nome: nome,
)
.telefone(telefone)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<UpdateMyProfileData, UpdateMyProfileVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.updateMyProfile(
  nome: nome,
);
UpdateMyProfileData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nome = ...;

final ref = ExampleConnector.instance.updateMyProfile(
  nome: nome,
).ref();
ref.execute();
```


### AdminCreateStudent
#### Required Arguments
```dart
String nome = ...;
int idade = ...;
String responsavel = ...;
String telefone = ...;
int presenca = ...;
ExampleConnector.instance.adminCreateStudent(
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminCreateStudent, we created `AdminCreateStudentBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminCreateStudentVariablesBuilder {
  ...
   AdminCreateStudentVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminCreateStudent(
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
)
.email(email)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminCreateStudentData, AdminCreateStudentVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminCreateStudent(
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
);
AdminCreateStudentData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nome = ...;
int idade = ...;
String responsavel = ...;
String telefone = ...;
int presenca = ...;

final ref = ExampleConnector.instance.adminCreateStudent(
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
).ref();
ref.execute();
```


### AdminUpdateStudent
#### Required Arguments
```dart
String id = ...;
String nome = ...;
int idade = ...;
String responsavel = ...;
String telefone = ...;
int presenca = ...;
ExampleConnector.instance.adminUpdateStudent(
  id: id,
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminUpdateStudent, we created `AdminUpdateStudentBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminUpdateStudentVariablesBuilder {
  ...
   AdminUpdateStudentVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminUpdateStudent(
  id: id,
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
)
.email(email)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminUpdateStudentData, AdminUpdateStudentVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminUpdateStudent(
  id: id,
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
);
AdminUpdateStudentData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String nome = ...;
int idade = ...;
String responsavel = ...;
String telefone = ...;
int presenca = ...;

final ref = ExampleConnector.instance.adminUpdateStudent(
  id: id,
  nome: nome,
  idade: idade,
  responsavel: responsavel,
  telefone: telefone,
  presenca: presenca,
).ref();
ref.execute();
```


### AdminLinkStudentAccount
#### Required Arguments
```dart
String studentId = ...;
String authUid = ...;
String authEmail = ...;
ExampleConnector.instance.adminLinkStudentAccount(
  studentId: studentId,
  authUid: authUid,
  authEmail: authEmail,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AdminLinkStudentAccountData, AdminLinkStudentAccountVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminLinkStudentAccount(
  studentId: studentId,
  authUid: authUid,
  authEmail: authEmail,
);
AdminLinkStudentAccountData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String studentId = ...;
String authUid = ...;
String authEmail = ...;

final ref = ExampleConnector.instance.adminLinkStudentAccount(
  studentId: studentId,
  authUid: authUid,
  authEmail: authEmail,
).ref();
ref.execute();
```


### AdminSetStudentStatus
#### Required Arguments
```dart
String id = ...;
String status = ...;
ExampleConnector.instance.adminSetStudentStatus(
  id: id,
  status: status,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AdminSetStudentStatusData, AdminSetStudentStatusVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminSetStudentStatus(
  id: id,
  status: status,
);
AdminSetStudentStatusData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String status = ...;

final ref = ExampleConnector.instance.adminSetStudentStatus(
  id: id,
  status: status,
).ref();
ref.execute();
```


### AdminCreateActivity
#### Required Arguments
```dart
String nome = ...;
String professor = ...;
int vagas = ...;
ExampleConnector.instance.adminCreateActivity(
  nome: nome,
  professor: professor,
  vagas: vagas,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminCreateActivity, we created `AdminCreateActivityBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminCreateActivityVariablesBuilder {
  ...
   AdminCreateActivityVariablesBuilder descricao(String? t) {
   _descricao.value = t;
   return this;
  }
  AdminCreateActivityVariablesBuilder horario(String? t) {
   _horario.value = t;
   return this;
  }
  AdminCreateActivityVariablesBuilder dias(String? t) {
   _dias.value = t;
   return this;
  }
  AdminCreateActivityVariablesBuilder categoria(String? t) {
   _categoria.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminCreateActivity(
  nome: nome,
  professor: professor,
  vagas: vagas,
)
.descricao(descricao)
.horario(horario)
.dias(dias)
.categoria(categoria)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminCreateActivityData, AdminCreateActivityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminCreateActivity(
  nome: nome,
  professor: professor,
  vagas: vagas,
);
AdminCreateActivityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nome = ...;
String professor = ...;
int vagas = ...;

final ref = ExampleConnector.instance.adminCreateActivity(
  nome: nome,
  professor: professor,
  vagas: vagas,
).ref();
ref.execute();
```


### AdminUpdateActivity
#### Required Arguments
```dart
String id = ...;
String nome = ...;
String professor = ...;
int vagas = ...;
String status = ...;
ExampleConnector.instance.adminUpdateActivity(
  id: id,
  nome: nome,
  professor: professor,
  vagas: vagas,
  status: status,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminUpdateActivity, we created `AdminUpdateActivityBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminUpdateActivityVariablesBuilder {
  ...
   AdminUpdateActivityVariablesBuilder descricao(String? t) {
   _descricao.value = t;
   return this;
  }
  AdminUpdateActivityVariablesBuilder horario(String? t) {
   _horario.value = t;
   return this;
  }
  AdminUpdateActivityVariablesBuilder dias(String? t) {
   _dias.value = t;
   return this;
  }
  AdminUpdateActivityVariablesBuilder categoria(String? t) {
   _categoria.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminUpdateActivity(
  id: id,
  nome: nome,
  professor: professor,
  vagas: vagas,
  status: status,
)
.descricao(descricao)
.horario(horario)
.dias(dias)
.categoria(categoria)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminUpdateActivityData, AdminUpdateActivityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminUpdateActivity(
  id: id,
  nome: nome,
  professor: professor,
  vagas: vagas,
  status: status,
);
AdminUpdateActivityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String nome = ...;
String professor = ...;
int vagas = ...;
String status = ...;

final ref = ExampleConnector.instance.adminUpdateActivity(
  id: id,
  nome: nome,
  professor: professor,
  vagas: vagas,
  status: status,
).ref();
ref.execute();
```


### AdminAssignActivity
#### Required Arguments
```dart
String alunoId = ...;
String atividadeId = ...;
ExampleConnector.instance.adminAssignActivity(
  alunoId: alunoId,
  atividadeId: atividadeId,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AdminAssignActivityData, AdminAssignActivityVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminAssignActivity(
  alunoId: alunoId,
  atividadeId: atividadeId,
);
AdminAssignActivityData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String alunoId = ...;
String atividadeId = ...;

final ref = ExampleConnector.instance.adminAssignActivity(
  alunoId: alunoId,
  atividadeId: atividadeId,
).ref();
ref.execute();
```


### AdminCreateScholarship
#### Required Arguments
```dart
String nome = ...;
double valorMensal = ...;
ExampleConnector.instance.adminCreateScholarship(
  nome: nome,
  valorMensal: valorMensal,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminCreateScholarship, we created `AdminCreateScholarshipBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminCreateScholarshipVariablesBuilder {
  ...
   AdminCreateScholarshipVariablesBuilder descricao(String? t) {
   _descricao.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminCreateScholarship(
  nome: nome,
  valorMensal: valorMensal,
)
.descricao(descricao)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminCreateScholarshipData, AdminCreateScholarshipVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminCreateScholarship(
  nome: nome,
  valorMensal: valorMensal,
);
AdminCreateScholarshipData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String nome = ...;
double valorMensal = ...;

final ref = ExampleConnector.instance.adminCreateScholarship(
  nome: nome,
  valorMensal: valorMensal,
).ref();
ref.execute();
```


### AdminUpdateScholarship
#### Required Arguments
```dart
String id = ...;
String nome = ...;
double valorMensal = ...;
bool ativa = ...;
ExampleConnector.instance.adminUpdateScholarship(
  id: id,
  nome: nome,
  valorMensal: valorMensal,
  ativa: ativa,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminUpdateScholarship, we created `AdminUpdateScholarshipBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminUpdateScholarshipVariablesBuilder {
  ...
   AdminUpdateScholarshipVariablesBuilder descricao(String? t) {
   _descricao.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminUpdateScholarship(
  id: id,
  nome: nome,
  valorMensal: valorMensal,
  ativa: ativa,
)
.descricao(descricao)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminUpdateScholarshipData, AdminUpdateScholarshipVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminUpdateScholarship(
  id: id,
  nome: nome,
  valorMensal: valorMensal,
  ativa: ativa,
);
AdminUpdateScholarshipData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String nome = ...;
double valorMensal = ...;
bool ativa = ...;

final ref = ExampleConnector.instance.adminUpdateScholarship(
  id: id,
  nome: nome,
  valorMensal: valorMensal,
  ativa: ativa,
).ref();
ref.execute();
```


### AdminAssignScholarship
#### Required Arguments
```dart
String alunoId = ...;
String bolsaId = ...;
double valorConcedido = ...;
ExampleConnector.instance.adminAssignScholarship(
  alunoId: alunoId,
  bolsaId: bolsaId,
  valorConcedido: valorConcedido,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AdminAssignScholarshipData, AdminAssignScholarshipVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminAssignScholarship(
  alunoId: alunoId,
  bolsaId: bolsaId,
  valorConcedido: valorConcedido,
);
AdminAssignScholarshipData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String alunoId = ...;
String bolsaId = ...;
double valorConcedido = ...;

final ref = ExampleConnector.instance.adminAssignScholarship(
  alunoId: alunoId,
  bolsaId: bolsaId,
  valorConcedido: valorConcedido,
).ref();
ref.execute();
```


### AdminCreateAgendaEntry
#### Required Arguments
```dart
String titulo = ...;
Timestamp inicio = ...;
ExampleConnector.instance.adminCreateAgendaEntry(
  titulo: titulo,
  inicio: inicio,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminCreateAgendaEntry, we created `AdminCreateAgendaEntryBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminCreateAgendaEntryVariablesBuilder {
  ...
   AdminCreateAgendaEntryVariablesBuilder descricao(String? t) {
   _descricao.value = t;
   return this;
  }
  AdminCreateAgendaEntryVariablesBuilder fim(Timestamp? t) {
   _fim.value = t;
   return this;
  }
  AdminCreateAgendaEntryVariablesBuilder local(String? t) {
   _local.value = t;
   return this;
  }
  AdminCreateAgendaEntryVariablesBuilder atividadeId(String? t) {
   _atividadeId.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminCreateAgendaEntry(
  titulo: titulo,
  inicio: inicio,
)
.descricao(descricao)
.fim(fim)
.local(local)
.atividadeId(atividadeId)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminCreateAgendaEntryData, AdminCreateAgendaEntryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminCreateAgendaEntry(
  titulo: titulo,
  inicio: inicio,
);
AdminCreateAgendaEntryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String titulo = ...;
Timestamp inicio = ...;

final ref = ExampleConnector.instance.adminCreateAgendaEntry(
  titulo: titulo,
  inicio: inicio,
).ref();
ref.execute();
```


### AdminUpdateAgendaEntry
#### Required Arguments
```dart
String id = ...;
String titulo = ...;
Timestamp inicio = ...;
String status = ...;
ExampleConnector.instance.adminUpdateAgendaEntry(
  id: id,
  titulo: titulo,
  inicio: inicio,
  status: status,
).execute();
```

#### Optional Arguments
We return a builder for each query. For AdminUpdateAgendaEntry, we created `AdminUpdateAgendaEntryBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class AdminUpdateAgendaEntryVariablesBuilder {
  ...
   AdminUpdateAgendaEntryVariablesBuilder descricao(String? t) {
   _descricao.value = t;
   return this;
  }
  AdminUpdateAgendaEntryVariablesBuilder fim(Timestamp? t) {
   _fim.value = t;
   return this;
  }
  AdminUpdateAgendaEntryVariablesBuilder local(String? t) {
   _local.value = t;
   return this;
  }
  AdminUpdateAgendaEntryVariablesBuilder atividadeId(String? t) {
   _atividadeId.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.adminUpdateAgendaEntry(
  id: id,
  titulo: titulo,
  inicio: inicio,
  status: status,
)
.descricao(descricao)
.fim(fim)
.local(local)
.atividadeId(atividadeId)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<AdminUpdateAgendaEntryData, AdminUpdateAgendaEntryVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminUpdateAgendaEntry(
  id: id,
  titulo: titulo,
  inicio: inicio,
  status: status,
);
AdminUpdateAgendaEntryData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String titulo = ...;
Timestamp inicio = ...;
String status = ...;

final ref = ExampleConnector.instance.adminUpdateAgendaEntry(
  id: id,
  titulo: titulo,
  inicio: inicio,
  status: status,
).ref();
ref.execute();
```


### AdminCreateNotification
#### Required Arguments
```dart
String destinatarioUid = ...;
String titulo = ...;
String mensagem = ...;
ExampleConnector.instance.adminCreateNotification(
  destinatarioUid: destinatarioUid,
  titulo: titulo,
  mensagem: mensagem,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AdminCreateNotificationData, AdminCreateNotificationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminCreateNotification(
  destinatarioUid: destinatarioUid,
  titulo: titulo,
  mensagem: mensagem,
);
AdminCreateNotificationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String destinatarioUid = ...;
String titulo = ...;
String mensagem = ...;

final ref = ExampleConnector.instance.adminCreateNotification(
  destinatarioUid: destinatarioUid,
  titulo: titulo,
  mensagem: mensagem,
).ref();
ref.execute();
```


### MarkMyNotificationRead
#### Required Arguments
```dart
String id = ...;
ExampleConnector.instance.markMyNotificationRead(
  id: id,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<MarkMyNotificationReadData, MarkMyNotificationReadVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.markMyNotificationRead(
  id: id,
);
MarkMyNotificationReadData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;

final ref = ExampleConnector.instance.markMyNotificationRead(
  id: id,
).ref();
ref.execute();
```


### RegisterMyDonation
#### Required Arguments
```dart
double valor = ...;
ExampleConnector.instance.registerMyDonation(
  valor: valor,
).execute();
```

#### Optional Arguments
We return a builder for each query. For RegisterMyDonation, we created `RegisterMyDonationBuilder`. For queries and mutations with optional parameters, we return a builder class.
The builder pattern allows Data Connect to distinguish between fields that haven't been set and fields that have been set to null. A field can be set by calling its respective setter method like below:
```dart
class RegisterMyDonationVariablesBuilder {
  ...
   RegisterMyDonationVariablesBuilder metodo(String? t) {
   _metodo.value = t;
   return this;
  }

  ...
}
ExampleConnector.instance.registerMyDonation(
  valor: valor,
)
.metodo(metodo)
.execute();
```

#### Return Type
`execute()` returns a `OperationResult<RegisterMyDonationData, RegisterMyDonationVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.registerMyDonation(
  valor: valor,
);
RegisterMyDonationData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
double valor = ...;

final ref = ExampleConnector.instance.registerMyDonation(
  valor: valor,
).ref();
ref.execute();
```


### AdminSetDonationStatus
#### Required Arguments
```dart
String id = ...;
String status = ...;
ExampleConnector.instance.adminSetDonationStatus(
  id: id,
  status: status,
).execute();
```



#### Return Type
`execute()` returns a `OperationResult<AdminSetDonationStatusData, AdminSetDonationStatusVariables>`
```dart
/// Result of an Operation Request (query/mutation).
class OperationResult<Data, Variables> {
  OperationResult(this.dataConnect, this.data, this.ref);
  Data data;
  OperationRef<Data, Variables> ref;
  FirebaseDataConnect dataConnect;
}

final result = await ExampleConnector.instance.adminSetDonationStatus(
  id: id,
  status: status,
);
AdminSetDonationStatusData data = result.data;
final ref = result.ref;
```

#### Getting the Ref
Each builder returns an `execute` function, which is a helper function that creates a `Ref` object, and executes the underlying operation.
An example of how to use the `Ref` object is shown below:
```dart
String id = ...;
String status = ...;

final ref = ExampleConnector.instance.adminSetDonationStatus(
  id: id,
  status: status,
).ref();
ref.execute();
```

