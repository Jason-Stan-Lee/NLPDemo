//
//  main.swift
//  NLPDemo
//
//  Created by JasonLee on 2019/5/24.
//  Copyright © 2019 JasonStanLee. All rights reserved.
//

import Foundation

print("----------------------- NLP ------------------------")

let nlp = NLP()
// 语言区分
nlp.determineLanguage(for: nlp.quote)
// 语句分割
nlp.tokenization(for: nlp.quote)
// 词形还原
nlp.lemmatization(for: nlp.quote)
// 词类划分
nlp.partsOfSpeech(for: nlp.quote)
// 命名实体识别
nlp.namedEntityRecognition(for: nlp.quote)

print("------------------- NLPCreateML ---------------------")

let nlpCreateML = NLPCreateML()
nlpCreateML.createML()
nlpCreateML.prediction("Feels so good!")
// Save model if you feels good
// nlpCreateML.saveModel(toFile: "file")
