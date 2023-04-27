//
//  main.swift
//  MyCreditManager
//
//  Created by kimyuri on 2023/04/27.
//

import Foundation

var menu: String
var students: [String:[String:String]] = [String:[String:String]]()
let score: [String:Double] = [
    "A+": 4.5,
    "A": 4,
    "B+": 3.5,
    "B": 3,
    "C+": 2.5,
    "C": 2,
    "D+": 1.5,
    "D": 1,
    "F": 0
]

repeat {
    print("""
    원하는 기능을 입력해주세요
    1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
    """)
    menu = readLine()!
    if ["1", "2", "3", "4", "5"].contains(menu) {
        switch menu {
        case "1":
            print("추가할 학생의 이름을 입력해주세요")
            let name = readLine() ?? ""
            if name.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else if students.keys.contains(name) {
                print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
            } else {
                students[name] = [String:String]()
                print("\(name) 학생을 추가했습니다.")
            }
        case "2":
            print("삭제할 학생의 이름을 입력해주세요")
            let name = readLine() ?? ""
            if name.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else if !students.keys.contains(name) {
                print("\(name) 학생을 찾지 못했습니다.")
            } else {
                students.removeValue(forKey: name)
                print("\(name) 학생을 삭제하였습니다.")
            }
        case "3":
            print("""
성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
입력예) Mickey Swift A+
만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
""")
            let input = readLine() ?? ""
            if input.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else {
                let info = input.split(separator: " ").map {String($0)}
                if info.count<3 {
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                } else {
                    let name = String(info[0])
                    let subject = String(info[1])
                    let grade = String(info[2])
                    if !students.keys.contains(name) {
                        print("\(name) 학생을 찾지 못했습니다.")
                    } else {
                        let grades = students[name]!
                        if grades.keys.contains(subject) {
                            students[name]!.updateValue(grade, forKey: subject)
                        } else {
                            students[name]?[subject] = grade
                        }
                    }
                }
            }
        case "4":
            print("""
성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.
입력예) Mickey Swift
""")
            let input = readLine() ?? ""
            if input.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else {
                let info = input.split(separator: " ").map {String($0)}
                if info.count<2 {
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                } else {
                    let name = String(info[0])
                    let subject = String(info[1])
                    if !students.keys.contains(name) {
                        print("\(name) 학생을 찾지 못했습니다.")
                    } else {
                        let grades = students[name]!
                        if !grades.keys.contains(subject) {
                            print("입력이 잘못되었습니다. 다시 확인해주세요.")
                        } else {
                            students[name]!.removeValue(forKey: subject)
                            print("\(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                        }
                    }
                }
            }
        case "5":
            print("""
평점을 알고싶은 학생의 이름을 입력해주세요
""")
            let name = readLine() ?? ""
            if name.isEmpty {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            } else {
                if !students.keys.contains(name) {
                    print("\(name) 학생을 찾지 못했습니다.")
                } else {
                    let grades: [String:String] = students[name]!
                    if grades.isEmpty {
                        print("입력이 잘못되었습니다. 다시 확인해주세요.")
                    } else {
                        var sum: Double = 0
                        for g in grades {
                            print("\(g.key): \(g.value)")
                            sum += score[g.value]!
                        }
                        print("평점 : \(sum/Double(grades.count))")
                    }
                }
            }
        default:
            continue
        }
    } else if menu != "X" {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
} while menu != "X"
