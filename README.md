# Mia
It is firestore wrapper with combine framework.

❗️ this package use firebase ios sdk __6.33-spm-beta__ branch ❗️

## installation

```Package.swift
.package(name: "Mia", url: "https://github.com/tera-ny/Mia.git", .branch("master"))
/// or
.package(name: "Mia", url: "https://github.com/tera-ny/Mia.git", from: "0.0.2")
```

## usage

```main.swift
import Mia

struct Room {
 let name: string
 let friends: [string]
 let isActive: bool
}

class FriendsViewModel: ObservableObject {
    @Published var friends: [Document<User>] = []
    var cancellable: AnyCancellable? = nil
    init() {
        bind()
    }
    func bind() {
        cancellable = Document<Room>.listen(query: Firestore.firestore().collection("room").whereField("friends", arrayContains: Auth.auth().currentUser!.uid).limit(to: 10)).sink(receiveCompletion: { error in
        }, receiveValue: { [weak self] friends in
            print("My friends..",friends.joined(separator: ","))
            self?.friends = friends
        })
    }
}
```
