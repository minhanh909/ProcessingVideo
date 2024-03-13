//
//  main.swift
//  New Project
//
//  Created by Minh Anh on 3/9/24.
//

import Foundation

struct Student {
    var codeID: String
    var name: String
    var age: Int
    var grade: String
}

class StudentManeger {
    private var students: [Student] = []
    
    func addStudentInfor(code: String,
                         name: String,
                         age: Int,
                         grade: String) {
        let newStudent = Student(codeID: code, name: name, age: age, grade: grade)
        students.append(newStudent)
        print("Student add successfully")
    }
    
    func editStudentInfor(index: Int,
                          newName: String?,
                          newAge: Int?,
                          newGrade: String?) {
        if index >= 0 && index < students.count {
            var updateStudent = students[index]
            
            if let newName = newName {
                updateStudent.name = newName
            }
            
            if let newAge = newAge {
                updateStudent.age = newAge
            }
            
            if let newGrade = newGrade {
                updateStudent.grade = newGrade
            }
            
            students[index] = updateStudent
            print("Student edited information successfully")
        } else {
            print("No found it. No student found at \(index)")
        }
    }
    
    func printStudentInfor() {
        if students.isEmpty {
            print("Didn't found student.")
        } else {
            print("\nStudent Informaton:")
            print("----------------")
            for (index, student) in students.enumerated() {
                print("Index: \(index),Code: \(student.codeID), Name: \(student.name), Age: \(student.age), Grade: \(student.grade)")
            }
            print("-----------------")
        }
    }
}

let manager = StudentManeger()

manager.addStudentInfor(code: "001", name: "Sarah", age: 15, grade: "9")
manager.addStudentInfor(code: "003", name: "Harry", age: 14, grade: "8")
manager.addStudentInfor(code: "034", name: "Colin", age: 17, grade: "11")

manager.printStudentInfor()

manager.editStudentInfor(index: 1, newName: "Jackson", newAge: 17, newGrade: "11")

manager.printStudentInfor()

