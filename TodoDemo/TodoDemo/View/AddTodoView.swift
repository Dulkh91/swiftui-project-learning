//
//  AddTodoView.swift
//  TodoDemo
//
//  Created by Ros Dul on 28/2/26.
//

import SwiftUI
internal import CoreData

struct AddTodoView: View {
    //MARK: - PROPERTY
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    
    let prioroties = ["Hight", "Normal","Low"]
    
    @State private var showingError: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                VStack (alignment: .leading, spacing: 20){
                    //MARK: - Todo name
                    TextField("Todo", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(12)
                        .font(.system(size: 24, weight: .bold, design: .default))
                    
                    //MARK: - PRIOROTY
                    Picker("Priority", selection: $priority){
                        ForEach(prioroties,id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Button {
                        if self.name != ""{
                            let todo = Todo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority
                            
                            do{
                                try self.managedObjectContext.save()
                                print("name: \(todo.name ?? ""),priority: \(todo.priority ?? "")")
                            }catch{
                                print("error")
                            }
                        }else{
                            self.showingError = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .background(Color.blue.cornerRadius(12))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(systemName: "xmark")
                            }

                        }
                    }
                    
                }//: VSTACK
                Spacer()
            }//: Vstack
            .padding()
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            }
        }//: Navigtion
        
    }
}

#Preview {
    AddTodoView()
}
