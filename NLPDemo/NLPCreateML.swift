//
//  NLPCreateML.swift
//  NLPDemo
//
//  Created by JasonLee on 2019/6/14.
//  Copyright © 2019 JasonStanLee. All rights reserved.
//

import Cocoa
import CreateML
import CreateML

class NLPCreateML {

    typealias TrainingData = (trainingData: MLDataTable, testData: MLDataTable)

    // data set url
    private let mlFileURL: URL? = {
        guard let filePath = Bundle.main.path(forResource: "NLPCreateMLData", ofType: "csv", inDirectory: "resources") else {
            return nil
        }
        
        return URL(fileURLWithPath: filePath)
    }()

    private var classfier: MLTextClassifier?

    // 训练模型
    func createML() {
        guard let url = mlFileURL,
            let allData = try? MLDataTable(contentsOf: url) else {
            return
        }

        let data: TrainingData = allData.randomSplit(by: 0.9)

        if #available(OSX 10.15, *) {
            guard let classfier = try? MLTextClassifier(trainingData: data.trainingData, textColumn: "text", labelColumn: "class", parameters: MLTextClassifier.ModelParameters()) else {
                return
            }
            let metrics = classfier.evaluation(on: data.testData, textColumn: "text", labelColumn: "class")
            print("classificationError: \(String(describing: metrics.classificationError))")
            self.classfier = classfier
        } else {
            guard let classfier = try? MLTextClassifier(trainingData: data.trainingData, textColumn: "text", labelColumn: "class") else {
                 return
            }
            let metrics = classfier.evaluation(on: data.testData, textColumn: "text", labelColumn: "class")
            print("classificationError: \(String(describing: metrics.classificationError))")
            self.classfier = classfier
        }

    }

    // 预测数据
    func prediction(_ text: String) {

        guard let ret = try? classfier?.prediction(from: text) else {
            print("prediction error")
            return
        }
        print("prediction result: \(String(describing: ret))")
    }

    // 保存模型
    func saveModel(toFile: String) {
        try? classfier?.write(toFile: toFile)
    }

}
