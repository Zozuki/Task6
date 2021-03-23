//
//  main.swift
//  Task6
//
//  Created by user on 20.03.2021.
//

import Foundation


protocol Heightable {
    var height: Int {get set}
}

class Student: Heightable {
    var height: Int
    var name: String
    
    init(height: Int, name: String) {
        self.height = height
        self.name = name
    }
}

class Teacher: Heightable {
    var height: Int
    var subject: String
    
    init(height: Int, subject: String) {
        self.height = height
        self.subject = subject
    }
}

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

struct queue<T:Heightable> {
    
    var elements = [T]()
    
    mutating func push(_ element: T) {
        elements.append(element)
    }
    
    mutating func pop() -> T? {
        guard elements.count > 0 else { return nil }
        return elements.removeFirst()
    }
    

//  2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
    
    mutating func filterHeight(predicate: (Int) -> Bool) -> [T] {
        
        let result = elements
        elements.removeAll()
        
        for element in result {
            if predicate(element.height) {
                elements.append(element)
            }
        }
        
        return elements
        
    }
    
    // Также рассматривал еще вариант возврата более конкретных значений и также возврата нового массива, а не измененния текущего, но из-за тайпкаста убивалась универсальность
        
    //    mutating func filterHeight(predicate: (Int) -> Bool)  -> [String] {
    //        var result = [String]()
    //        for element in elements {
    //            if predicate(element.height) {
    //                guard let student = element as? Student else { return ["\(T.self)"] }
    //                result.append("Имя: \(student.name), Рост: \(student.height)")
    //            }
    //        }
    //        return result
    //    }
    
    // Печать роста каждого элемента массива
    
    func printQueueHeights() {
        for elem in elements {
            print(elem.height)
        }
    }
    
}

//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

extension queue {
    
    subscript(index: Int) -> T? {
        if index > elements.count || index < 0 {
            return nil
        } else {
            return elements[index]
        }
    }
    
}

let student1 = Student(height: 160, name: "Jack")
let student2 = Student(height: 170, name: "Nick")
let student3 = Student(height: 175, name: "Oliver")
var studentsQueue = queue<Student>()

studentsQueue.push(student1)
studentsQueue.push(student2)
studentsQueue.push(student3)

studentsQueue.printQueueHeights() // напечатали рост каждого элемента
print("________\n")
studentsQueue.filterHeight() {$0 > 160} // удалили элементы с ростом меньше 160
studentsQueue.printQueueHeights() // напечатали рост каждого оставшегося элемента

print(studentsQueue[1]!.name) // вернет имя элемента по индексу
print(studentsQueue[-1]!) // вернет nil

print("________\n")

let teacher1 = Teacher(height: 170, subject: "Math")
let teacher2 = Teacher(height: 165, subject: "History")
let teacher3 = Teacher(height: 180, subject: "Music")
var teacherQueue = queue<Teacher>()

teacherQueue.push(teacher1)
teacherQueue.push(teacher2)
teacherQueue.push(teacher3)
teacherQueue.printQueueHeights()
print("________\n")
teacherQueue.pop()
teacherQueue.printQueueHeights()







