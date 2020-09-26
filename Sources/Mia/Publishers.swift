//
//  Publishers.swift
//  
//
//  Created by teranayn on 2020/09/26.
//

import Foundation
import FirebaseFirestore
import Combine

struct FirestoreCollectionPublisher<Model: Codable>: Publisher {
    typealias Output = [Document<Model>]
    typealias Failure = Error
    let query: Query
    init(query: Query) {
        self.query = query
    }
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = FirestoreSubscription(query: query, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

struct FirestoreDocumentPublisher<Model: Codable>: Publisher {
    typealias Output = Document<Model>
    typealias Failure = Error
    let ref: DocumentReference
    init(documentRef: DocumentReference) {
        self.ref = documentRef
    }
    func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = FirestoreSubscription(documentRef: ref, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}
