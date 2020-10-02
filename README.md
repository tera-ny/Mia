# Mia
It is firestore wrapper with combine framework.

❗️ this package use firebase ios sdk __6.33-spm-beta__ branch ❗️

## installation

```Package.swift
.package(name: "Mia", url: "https://github.com/tera-ny/Mia.git", .branch("master"))
```

## usage

```main.swift
import Mia

struct Room {
 let name: string
 let friends: [string]
 let isActive: bool
}

class RoomsViewModel: ObservableObject {
    @Published var rooms: [Document<Room>] = []
    var cancellable: AnyCancellable? = nil
    let query = Firestore.firestore().collection("room").whereField("friends", arrayContains: Auth.auth().currentUser!.uid).limit(to: 10)).limit(to: 10)
    init() {
        bind()
    }
    func bind() {
        cancellable = Document<Room>.listen(query: query)
        .sink(receiveCompletion: { error in
            print(error)
        }, receiveValue: { [weak self] rooms in
            print("My friends..",rooms.friends.joined(separator: ","))
            self?.rooms = rooms
        })
    }
}
```
