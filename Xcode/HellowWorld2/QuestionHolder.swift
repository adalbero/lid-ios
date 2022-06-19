//
//  QuestionHolder.swift
//  HellowWorld2
//
//  Created by Mathias Bergmann Guimaraes on 15.06.22.
//

import Foundation

struct QuestionHolder{
    var questionsHolding: [Questions]
    var header: String
    var comment: String
    
    init(questions_to_hold: [Questions], header: String, comment: String){
        self.questionsHolding = questions_to_hold
        self.header = header
        self.comment = comment
    }
    
    mutating func addQuestion(question_to_add: Questions){
        questionsHolding.append(question_to_add)
    }
    
    func getSize() -> Int{
        return questionsHolding.count
    }
}
