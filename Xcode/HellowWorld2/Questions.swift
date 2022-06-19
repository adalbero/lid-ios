//
//  Questions.swift
//  HellowWorld2
//
//  Created by Mathias Bergmann Guimaraes on 10.06.22.
//

import Foundation


struct Questions {
    var num: String
    var question: String
    var a: String
    var b: String
    var c: String
    var d: String
    var solution: String
    var area_code: String
    var area: String
    var theme: String
    var image: String
    var tags: String
    
    init(inputColumn: [String]){
         num = inputColumn[0]
        question = inputColumn[1]
         a = inputColumn[2]
         b = inputColumn[3]
         c = inputColumn[4]
         d = inputColumn[5]
         solution = inputColumn[6]
         area_code = inputColumn[7]
         area = inputColumn[8]
         theme = inputColumn[9]
         image = inputColumn[10]
         tags = inputColumn[11]
    }
}

func loadCSV(from csvName: String) ->[Questions] {
    var csvToStruct = [Questions]()
    
    //locate the csv file
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return[]
    }
    
    //convert the contents of the file into one very long string
    var data = ""
    
    do{
        data = try String(contentsOfFile: filePath)
    } catch{
        print(error)
        return[]
    }
    
    var rows = data.components(separatedBy: "\n")
    
    rows.removeFirst()
    rows.removeLast()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: ";")
        let questionsStruct = Questions.init(inputColumn: csvColumns)
        csvToStruct.append(questionsStruct)
    }
    
    return csvToStruct
}
