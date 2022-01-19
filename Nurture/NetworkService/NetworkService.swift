//
//  NetworkService.swift
//  Nurture
//
//  Created by Emmanuel Okwara on 29/12/2021.
//

import Foundation
import Firebase

public typealias Closure = () -> ()
public typealias Params = [String: Any]
public typealias FIRDocument = [String: Any]

enum FirebaseCollection: String {
    case users
    case habits
}

struct NetworkService {
    
    public static let shared = NetworkService()
    
    private let database = Firestore.firestore()
    
    
    func register(email: String, password: String, completion: @escaping(Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email,
                               password: password) { (authResult, error) in
            guard let user = authResult?.user, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success("User Created"))
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success("User Logged In"))
        }
    }
    
    func createHabit(_ habit: CreateForm, completion: @escaping (Result<String, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        database
            .collection(FirebaseCollection.users.rawValue)
            .document(uid)
            .collection(FirebaseCollection.habits.rawValue)
            .document(habit.id)
            .setData(habit.asDictionary) { err in
                if let error = err {
                    completion(.failure(error))
                } else {
                    completion(.success("Habit Successfully Created"))
                }
            }
    }
    
    func updateHabit(_ habit: CreateForm, completion: @escaping (Result<String, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        database
            .collection(FirebaseCollection.users.rawValue)
            .document(uid)
            .collection(FirebaseCollection.habits.rawValue)
            .document(habit.id)
            .setData(habit.asDictionary, merge: true) { err in
                if let error = err {
                    completion(.failure(error))
                } else {
                    completion(.success("Habit Successfully Updated"))
                }
            }
    }
    
    func deleteHabit(_ habit: CreateForm, completion: @escaping (Result<String, Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        database
            .collection(FirebaseCollection.users.rawValue)
            .document(uid)
            .collection(FirebaseCollection.habits.rawValue)
            .document(habit.id).delete() { err in
                if let error = err {
                    completion(.failure(error))
                } else {
                    completion(.success("Habit Successfully Deleted"))
                }
            }
    }
    
    func fetchHabits(completion: @escaping(Result<[CreateForm], Error>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        database
            .collection(FirebaseCollection.users.rawValue)
            .document(uid)
            .collection(FirebaseCollection.habits.rawValue)
            .getDocuments() { (querySnapshot, err) in
                if let error = err {
                    completion(.failure(error))
                } else {
                    var forms = [CreateForm]()
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let id = (data["id"] as? String) ?? ""
                        let title = (data["title"] as? String) ?? ""
                        let time = (data["time"] as? [String]) ?? []
                        let days = (data["days"] as? [String]) ?? []
                        let emoji = (data["emoji"] as? String) ?? ""
                        let createForm = CreateForm(id: id, title: title, time: time, days: days, emoji: emoji)
                        forms.append(createForm)
                       
                    }
                    completion(.success(forms))
                }
            }
        
    }
}
