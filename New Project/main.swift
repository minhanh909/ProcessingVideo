//
//  main.swift
//  New Project
//
//  Created by Minh Anh on 3/9/24.
//

import Foundation
import CommonCrypto

extension Data {
    public func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }

    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }

        return hexString
    }
}

public extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}

struct Book {
    var id: String  /// 63147dfe-843cdfb2-001  ,    63147dfe-843cdfb2-002
    var name: String   /// nhung   co gai mat tich
    var category: String
    var isBorrowed: Bool
}

class ManageLibraryBooks {
    var books = [Book]()

    func addBook(name: String, category: String) {
        let id = name.sha256().suffix(8) + "-" + category.sha256().suffix(8) + "-" + "001"
        let newBook = Book(id: id,
                           name: name,
                           category: category,
                           isBorrowed: false)
        books.append(newBook)
    }

    func updateBook(searchId: String,
                    newName: String?,
                    newCategory: String?) {

        // detect from searchId to find similar book
        for (index, aBook) in books.enumerated() {
            if aBook.id == searchId {

                // => found that book
                var foundBook = aBook

                // update info for that book
                if let newName = newName {
                    foundBook.name = newName
                }

                if let newCategory = newCategory {
                    foundBook.category = newCategory
                }

                books[index] = foundBook
                break
            }
        }
    }

    func borrowBook(id: String) -> Book? {
        // Find book by id
        for (index, aBook) in books.enumerated() {
            if aBook.id == id {
                if aBook.isBorrowed {
                    print("Someone who borrowed the book")
                } else {
                    books[index].isBorrowed = true
                }
                return books[index]
            }
        }

        return nil
        // if book is borrowed by someone -> return "Someone who is borrowede the book"
        // else set book state will be borrowed


        // find index of book by id
        guard let index = books.firstIndex(where: { aBook in aBook.id == id})
            else { return nil }

        // update book state
        if books[index].isBorrowed {
            print("Someone who borrowed the book")
        } else {
            books[index].isBorrowed = true
        }

        // return found book
        return books[index]


        // find index of book by id
        if let index = books.firstIndex(where: { aBook in aBook.id == id}) {
            // update book state
            if books[index].isBorrowed {
                print("Someone who borrowed the book")
            } else {
                books[index].isBorrowed = true
            }

            // return found book
            return books[index]
        }

        return nil
    }

//    func getBook(by index: Int) -> Book {
//        return books[index]
//    }

    func checkIsNil(number: Int?) -> Bool {
//        if number != nil {
//            return true
//        } else {
//            return false
//        }

//        if number != nil {
//            return true
//        }
//
//        return false

//        guard number != nil else {
//            return false
//        }
//
//        return true


        return (number != nil) // true
        // return true
        // return false

    }


    func findBook(by id: String) -> Book? {
        // find book by id

        for aBook in books {
            if aBook.id == id {
                return aBook
            }
        }

//        for aBook in books where aBook.id == id {
//            return aBook
//        }

        return nil

        // high function
//        return books.first(where: { $0.id == id })
    }

    func printBookList() {
        print("The library has books:")
        for abook in books {
            print("\nId: \(abook.id) \nThe name: \(abook.name) \nThe catogory: \(abook.category) ")
        }
    }
}
    
let manageBook = ManageLibraryBooks()
manageBook.addBook(name: "nhung co gai mat tich", category: "tieu thuyet")
manageBook.addBook(name: "cuoc phieu luu robinson", category: "tieu thuyet")
manageBook.addBook(name: "trinh tham conan", category: "trinh tham")
manageBook.addBook(name: "kham pha kim tu thap", category: "kham pha the gioi")
manageBook.addBook(name: "100 thi nghiem hoa hoc", category: "khoa hoc")
manageBook.addBook(name: "99 de toan thi dai hoc", category: "toan hoc")

manageBook.printBookList()
// books[6]

//manageBook.updateBook(searchId: "44439397-11dbc31d-001",
//                      newName: "nhung co gai dung cam",
//                      newCategory: "khoa hoc")
//
//let foundBook = manageBook.borrowBook(id: "44439397-11dbc31d-0012")
let checkBook = manageBook.findBook(by: "19df027d-cec069b4-00134")

if let checkBook = checkBook {
    print("--------------")
    print("The book of name is \(checkBook.name) that is in the library")
} else {
    print("--------------")
    print("Sorry. There are no books in the library")
}

