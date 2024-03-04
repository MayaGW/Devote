//
//  ContentView.swift
//  Devote
//
//  Created by Maya Ghamloush on 02/03/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    //MARK: - PROPERTIES
    @State var task: String = ""
    @State private var showNewTaskItem: Bool = false
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
 
    //MARK: - FETCHING DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    //MARK: - FUNCTIONS
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    //MARK: - BODY
    var body: some View {
        NavigationView {
            ZStack {
                
                //MARK: - MAIN VIEW
                VStack {
                    //MARK: - HEADERR
                    HStack(spacing: 10){
                        //Title
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading,4)
                        
                        Spacer()
                        //EDITBUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal,10)
                            .frame(minWidth: 24, maxWidth: 70,   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .background(
                                Capsule().stroke(Color.white, lineWidth: 2)
                            )
                        //APPPEARENCE BUtton
                        Button(action: {
                            isDarkMode.toggle()
                            //Toggle appearance
                        }, label: {
                            Image(systemName: isDarkMode ?  "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24,height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                        
                        
                    }//HSTACK
                    .padding()
                    .foregroundColor(.white)
                    
                    
                    Spacer(minLength: 80)
                    //MARK: - NEW TASK BUTTON
                    
                    
                    
                    Button(action: {
                        showNewTaskItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        Text("New Task")
                            .font(.system(size: 24, weight: .semibold, design: .rounded))
                         
                    })
                    .foregroundColor(.white)
                    .padding(.horizontal,20)
                    .padding(.vertical,15)
                    .background(
                        LinearGradient(colors: [.pink,.blue], startPoint: .leading, endPoint: .trailing)
                            .clipShape(Capsule())
                    )
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
                    //MARK: - TASKS
                    
                    
                    List {
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                         
                        }
                        .onDelete(perform: deleteItems)
                    }//List
                    .scrollContentBackground(.hidden)
                    //.background(Color.clear)
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0).opacity(0.3), radius: 12)
                    .padding(.vertical,0)
                .frame(maxWidth: 640)
                }//VSTACK
                
              //MARK: - NEW TASK ITEM
                if showNewTaskItem{
                    BlankView()
                        .onTapGesture {
                            showNewTaskItem = false
                        }
                    NEwTaskItemView(isShowing: $showNewTaskItem)
                }
            }//ZSTACK
            
            .navigationBarTitle("Daily Task", displayMode: .large)
            .navigationBarHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
           // }//TOOLBAR
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient.ignoresSafeArea(.all))
            
        }//NAVIGATION
        .navigationViewStyle(StackNavigationViewStyle())
    }//STRUCT
    
}




#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
