//
//  ContentView.swift
//  iExpense
//
//  Created by Boran Roni on 10.10.2022.
//

import SwiftUI
struct ExpenseItem: Identifiable, Codable {
    var id = UUID() //this gives the item a unique id, so no duplicates
    let name: String
    let type: String
    let amount: Double
}
class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    var personalItems: [ExpenseItem] {
        items.filter { $0.type == "Personal"}
        
    }
    var businessItems: [ExpenseItem] {
        items.filter { $0.type == "Business"}
        
    }
}
struct ContentView: View {
    @State private var showingAddExpense = false
    @StateObject var expenses = Expenses()
    var body: some View {
        NavigationView{
            List{
                Section{
                    ForEach(expenses.personalItems){ item in
                        HStack{
                            
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount,format: .currency(code: Locale.current.identifier))
                                    .foregroundColor(item.amount < 5 ? Color.green: (item.amount < 10 ? Color.blue: (item.amount < 100 ? Color.white: Color.red)))
                                
                            
                        }
                        
                    }
                    
                    .onDelete(perform: removeItems)
                }
                Section{
                    ForEach(expenses.businessItems){ item in
                        HStack{
                            
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                Spacer()
                                Text(item.amount,format: .currency(code: Locale.current.identifier))
                                    .foregroundColor(item.amount < 5 ? Color.green: (item.amount < 10 ? Color.blue: (item.amount < 100 ? Color.white: Color.red)))
                                
                            
                        }
                        
                    }
                    
                    .onDelete(perform: removeItems)
                }

                

            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    //let expense = ExpenseItem(name:"Test",typer: "Personal", amount: 5)
                    //expenses.items.append(expense)
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense){
            AddView(expenses: expenses)
        }
    }
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
