//
//  NEwTaskItemView.swift
//  Devote
//
//  Created by Maya Ghamloush on 03/03/2024.
//

import SwiftUI

struct NEwTaskItemView: View {
    //MARK: - PROPERTIES
    @Environment(\.managedObjectContext) private var viewContext
    @State var task: String = ""
    @Binding var isShowing: Bool
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    
    private var isButtonDisabled: Bool{
        task.isEmpty
    }
    //MARK: - FUNCTIONS
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            task = ""
            hideKeyboard()
            isShowing = false
        }
    }
    //MARK: - BODY
    var body: some View {
        VStack{
            Spacer()
            VStack {
                VStack(spacing: 16){
                    TextField("New Task", text: $task)
                        .foregroundColor(.pink)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .padding()
                        .background(
                            isDarkMode ? Color(UIColor.tertiarySystemBackground) :
                                Color(UIColor.secondarySystemBackground)
                        )
                        .cornerRadius(10)
                    
                    Button(action: {
                        addItem()
                    }, label: {
                        Spacer()
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                        Spacer()
                    })
                    .disabled(isButtonDisabled)
                    .padding()
              
                    .foregroundColor(.white)
                    .background(isButtonDisabled ? Color.blue : Color.pink)
                    .cornerRadius(10)
                }//VSTACK
              
            }//VSTACK
            .padding(.horizontal)
            .padding(.vertical,20)
            .background(
                isDarkMode ? Color(UIColor.secondarySystemBackground) :
                    Color.white
            
            )
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.65), radius: 24)
            .frame(maxWidth: 640)
        }//VSTACK
        .padding()
    }//BODY
}//STRUCT
#Preview {
    NEwTaskItemView(isShowing: .constant(true))
        .background(Color.gray.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
}
