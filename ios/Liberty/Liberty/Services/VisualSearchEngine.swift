//
//  VisualSearchEngine.swift
//  Liberty
//
//  Created by Alexandr Olferuk on 10/27/18.
//  Copyright © 2018 Olferuk. All rights reserved.
//

struct Hypothesis {
    var product: Product
    var confidence: Double
}

class VisualSearchEngine {

    static var threshold: Double = 0.77

    static func searchCheck(of vector: [Double]) {
        let cosine = EMSimilarity()
        let db = cosine.compute(A: SampleBook.embedding, B: vector)
        let dg = cosine.compute(A: SampleHuman.embedding, B: vector)
        print("Distanse to the book: \(db)")
        print("Distanse to Grisha: \(dg)")
        print("=========================")
    }

    static func performSearch(of vector: [Double], in collection: [Product]) -> Hypothesis? {
        let cosine = EMSimilarity()
        return collection.map { Hypothesis(product: $0, confidence: cosine.compute(A: Array($0.embedding), B: vector)) }
            .filter { $0.confidence > threshold }
            .sorted { $0.confidence < $1.confidence }
            .first
    }
}
