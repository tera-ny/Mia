//
//  Publishers.swift
//  
//
//  Created by teranayn on 2020/09/26.
//

import Foundation
import FirebaseFirestore
import Combine

public struct FirestoreCollectionPublisher<Model: Codable>: Publisher {
    public typealias Output = [Document<Model>]
    public typealias Failure = Error
    public let query: Query
    public init(query: Query) {
        self.query = query
    }
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = FirestoreSubscription(query: query, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

public struct FirestoreDocumentPublisher<Model: Codable>: Publisher {
    public typealias Output = Document<Model>
    public typealias Failure = Error
    public let ref: DocumentReference
    public init(documentRef: DocumentReference) {
        self.ref = documentRef
    }
    public func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = FirestoreSubscription(documentRef: ref, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}
