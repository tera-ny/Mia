//
//  Document.swift
//  
//
//  Created by teranyan on 2020/09/26.
//

import FirebaseFirestoreSwift
import FirebaseFirestore
import Combine

struct Document<Model: Codable> {
    let ref: DocumentReference
    let data: Model
    static func get(collectionPath: String, id: String) -> Deferred<Future<Document<Model>, Error>> {
        .init { () -> Future<Document<Model>, Error> in
            let document = Firestore.firestore().collection(collectionPath).document(id)
            return get(documentRef: document)
        }
    }
    
    static func get(documentRef: DocumentReference) -> Deferred<Future<Document<Model>, Error>> {
        .init { () -> Future<Document<Model>, Error> in
            get(documentRef: documentRef)
        }
    }
    
    static func listen(documentRef: DocumentReference) -> Deferred<FirestoreDocumentPublisher<Model>> {
        .init { () -> FirestoreDocumentPublisher<Model> in
            listen(documentRef: documentRef)
        }
    }
    
    static func listen(query: Query) -> Deferred<FirestoreCollectionPublisher<Model>> {
        .init { () -> FirestoreCollectionPublisher<Model> in
            listen(query: query)
        }
    }
    
    private static func get(documentRef: DocumentReference) -> Future<Document<Model>, Error> {
        .init { observer in
            documentRef.getDocument { (snapshot, error) in
                if let error = error {
                    observer(.failure(error))
                } else {
                    do {
                        let data = try snapshot!.data(as: Model.self, decoder: Firestore.Decoder())!
                        observer(.success(.init(ref: documentRef, data: data)))
                    } catch {
                        observer(.failure(error))
                    }
                }
            }
        }
    }
    
    private static func get(query: Query) -> Future<[Document<Model>], Error> {
        .init { observer in
            query.getDocuments { (snapshot, error) in
                if let error = error {
                    observer(.failure(error))
                } else {
                    do {
                        let data = try snapshot!.documents.map { document -> Document<Model> in
                            let data = try document.data(as: Model.self, decoder: Firestore.Decoder())!
                            return .init(ref: document.reference, data: data)
                        }
                        observer(.success(data))
                    } catch {
                        observer(.failure(error))
                    }
                }
            }
        }
    }
    
    private static func listen(documentRef: DocumentReference) -> FirestoreDocumentPublisher<Model> {
        return .init(documentRef: documentRef)
    }
    
    private static func listen(query: Query) -> FirestoreCollectionPublisher<Model> {
        return .init(query: query)
    }
}
