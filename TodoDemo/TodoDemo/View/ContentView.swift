//
//  ContentView.swift
//  TodoDemo
//
//  Created by Ros Dul on 28/2/26.
//

import SwiftUI
internal import CoreData

struct ContentView: View {
    //MARK: - PROPERTY
    
    @Environment(\.managedObjectContext) var managerObjectContext
    
    @FetchRequest(entity: Todo.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    var todos: FetchedResults<Todo>
    
    @State private var showingSettingView: Bool = false
    @State private var showingAddTodoView: Bool = false
    @State private var isAnimateButton: Bool = false
    
    //MARK: - BODY
    var body: some View {
        NavigationStack{
            ZStack{
                List{
                    ForEach(self.todos, id: \.self){ todo in
                        HStack {
                            Text(todo.name ?? "unknow")
                            
                            Spacer()
                            
                            Text(todo.priority ?? "unknow")
                        }
                    }
                    .onDelete(perform: deleteTodo)
                }//: List
                .listStyle(.plain)
                .navigationTitle("Todo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showingSettingView.toggle()
                        } label: {
                            Image(systemName: "paintbrush")
                        }
                        .sheet(isPresented: $showingSettingView) {
                            SettingsView().environment(\.managedObjectContext, self.managerObjectContext)
                        }
                    }//: ToolbarItem
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                        
                    }//: ToolbarItem
                }//: toolbar
                
                //MARK: - NO DATA
                if todos.count == 0{
                    EmptyListView()
                }
                
            }//: ZSTACK
            .padding(.horizontal)
            .sheet(isPresented: $showingAddTodoView) {
                AddTodoView().environment(\.managedObjectContext, self.managerObjectContext)
            }
            .overlay(alignment: .bottomTrailing) {
                ZStack {
                    Group{
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 68,height: 68)
                            .opacity(self.isAnimateButton ? 0.2:0)
                            .scaleEffect(self.isAnimateButton ? 1: 0)
                    
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 88, height: 88)
                            .opacity(self.isAnimateButton ? 0.15:0)
                            .scaleEffect(self.isAnimateButton ? 1:0)
                    }
                            
                    
                    Button {
                        self.showingAddTodoView.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .background(
                                Circle()
                                    .fill(Color("ColorBase"))
                            )
                            .frame(width: 48,height: 48, alignment: .center)
                    }//: Button
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 2)
                            .repeatForever(autoreverses: true)
                        ) {
                            isAnimateButton = true
                        }
                        
                    }
                }
                .padding()
                .padding(.bottom, -30)
                .padding(.trailing, 10)

            }//: OVERLAY
            
        }//: NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    //MARK: - Function
    private func deleteTodo(at offsets: IndexSet){
        for index in offsets{
            let todo = todos[index] //find index of todo
            managerObjectContext.delete(todo)
            
            do{
                try managerObjectContext.save()
            }catch{
                print("Error")
            }
        }
    }//: deleteTodo
    
}




#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    
}

