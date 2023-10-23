//
//  QuestionsViews.swift
//  ProyectoChipil
//
//  Created by Oscar Valdes on 23/10/23.
//
import SwiftUI
import FirebaseFirestore

struct QuestionsViews: View {
    var info: Informacion
   @State var questions: [Preguntas]
    var onFinish: ()->()
    
    @Environment(\.dismiss) private var dismiss
    //con esat variable privada podemos manejar graficos
    @State private var progress: CGFloat = 0
    //con esta variable guardamos el numero de una variable para poder asignar una pregunta a la vez
    @State private var currentIndex: Int = 0
    //con esta variable manejaremos el progreso del usuario para finalizar el cuestionario
    @State private var score: CGFloat = 0
    //variable que contendra el la puntuacion de la tarjeta de puntos
    @State private var showScoreCard: Bool = false
    
    var body: some View {
        
        VStack{
            Button{
                dismiss()
            }label: {
                Image(systemName: "xmark")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
            .hAligh(.leading)
            Text(info.title)
                .font(.title)
                .fontWeight(.semibold)
                .hAligh(.leading)
            
            GeometryReader{
                let size = $0.size
                ZStack(alignment:.leading){
                    Rectangle()
                        .fill(.black.opacity(0.2))
                    Rectangle()
                        .fill(Color("Progress"))
                        .frame(width: progress * size.width, alignment: .leading)
                }
                .clipShape(Capsule())
            }
            .frame(height: 20)
            .padding(.top,5)
            //Animacion y estructura visual de las preguntas
            GeometryReader{_ in
                ForEach(questions.indices, id:\.self){ index in
                    //usaremos transiciones para movernos entre las preguntas en lugar de botones o TabViws
                    if currentIndex == index{
                        QuestionView(questions[currentIndex])
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                    }
                }
            }
            //remover padding unicamente horizantal
            .padding(.horizontal,-15)
            .padding(.vertical,25)
            //este boton mandara a la siguiente pregunta hasta que se finalice
            CustomButton(title: currentIndex == (questions.count - 1) ? "Finalizar" : "Siguiente Pregunta"){
                if currentIndex == (questions.count - 1){
                    //presentacion de la tarjeta de puntuación
                    showScoreCard.toggle()
                }else{
                    withAnimation(.easeInOut){
                        currentIndex += 1
                        progress = CGFloat(currentIndex) / CGFloat(questions.count - 1)
                        
                    }
                }
            }
        }
        .padding(15)
        .hAligh(.center).vAligh(.top)
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
        //Como nuestro fondo es obscuro, hay que forzar el Modo obscurom en la App
        .environment(\.colorScheme, .dark)
        //hacemos que al momento de finalizar el test nos muestre una medalla en toda la View
        .fullScreenCover(isPresented: $showScoreCard){
            ScoreCardView(score: score / CGFloat(questions.count) * 100){
                dismiss()
                onFinish()
            }
        }
    }
    
    
    //View de preguntas
    @ViewBuilder
    func QuestionView(_ question: Preguntas)->some View{
        VStack(alignment: .leading, spacing: 15){
            Text("Pregunta\(currentIndex + 1)/\(questions.count)")
                .font(.callout)
                .foregroundColor(.gray)
                .hAligh(.leading)
            
            Text(question.question)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            VStack(spacing: 12){
                ForEach(question.options,id:\.self){ option in
                    //mostrar las respues, ya sean correctas o incorrectas
                    ZStack{
                        OptionView(option, .gray)
                            .opacity(question.answer == option && question.tappedanswer != "" ? 0 : 1)
                        OptionView(option, .green)
                            .opacity(question.answer == option && question.tappedanswer != "" ? 1 : 0)
                        OptionView(option, .red)
                            .opacity(question.tappedanswer == option && question.tappedanswer != question.answer ? 1 : 0)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture{
                        guard questions[currentIndex].tappedanswer == "" else{return}
                            withAnimation(.easeInOut){
                                questions[currentIndex].tappedanswer = option
                                //cuando se sleccione una opcion en el cuestionario se axctualiza la barra de estado
                                if question.answer == option{
                                    score += 1.0
                                }
                            }
                    }
                }
            }
            .padding(.vertical,10)
        }
        .padding(15)
        .hAligh(.center)
        .background{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
        }
        .padding(.horizontal,15)
    }
    @ViewBuilder
    func OptionView(_ option: String, _ tint: Color)->some View{
        Text(option)
            .foregroundColor(tint)
            .padding(.horizontal,15)
            .padding(.vertical,20)
            .hAligh(.leading)
            .background{
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(tint.opacity(0.15))
                    .background{
                        RoundedRectangle(cornerRadius: 12,style: .continuous)
                            .stroke(tint.opacity(tint == .gray ? 0.15 : 1), lineWidth: 2)
                    }
            }
    }
}

#Preview {
    ContentView(authenticationViewModel: AuthenticationViewModel())
}

//estructura del modelo de la vista de tarjeta de puntuacion
struct ScoreCardView: View{
    var score: CGFloat
    //regresa al inicio de los cuestionarios cuando se ejecuda dismiss
    var onDismiss: ()->()
    @Environment(\.dismiss) private var dismiss

 
    var body: some View{
        VStack{
            VStack(spacing: 15){
                Text("Resultado de tu ejercicio")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                VStack(spacing: 15){
                    Text("felicidades por tu puntuación")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Text(String(format: "%.0f", score) + "%")
                        .font(.title.bold())
                        .padding(.bottom,10)
                    
                    Image(systemName: "person.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 220)
                }
                .foregroundColor(.black)
                .padding(.horizontal,15)
                .padding(.vertical,20)
                .hAligh(.center)
                .background{
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.white)
                }
            }
            .vAligh(.center)
            CustomButton(title: "Regresar al inicio"){
                //despues de cerrar el test actualizar en firestore el numero de personas asistidas
                Firestore.firestore().collection("Cuestionarios").document("Informacion").updateData(["peopleAttended": FieldValue.increment(1.0)])
                onDismiss()
                dismiss()
            }
        }
        .padding(15)
        .background{
            Color("BG")
                .ignoresSafeArea()
        }
    }
}


/*palabras clave

tappedanswer = respuesta intervenida
 answer      = respuesta
 acore       = puntaje
 FieldValue  = valor de campo
*/
