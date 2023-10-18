//
//  QuizView.swift
//  Chipil_test
//
//  Created by ximena mejia  on 19/09/23.
//
/*
import SwiftUI

struct QuizView: View {
    let questions: [Question]
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswerIndices = [Int?](repeating: nil, count: questions.count)

    var body: some View {
        VStack {
            if currentQuestionIndex < questions.count {
                QuestionView(question: questions[currentQuestionIndex], selectedAnswerIndex: $selectedAnswerIndices[currentQuestionIndex])

                Button(action: {
                    if currentQuestionIndex < questions.count - 1 {
                        currentQuestionIndex += 1
                    }
                }) {
                    Text("Siguiente")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Text("Has terminado el cuestionario.")
                    .font(.headline)
            }
        }
        .padding()
    }
}


#Preview {
    QuizView()
}/*
