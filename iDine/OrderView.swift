//
//  OrderView.swift
//  iDine
//
//  Created by Admin on 11/23/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    
    static let destinations = ["London", "San Diego", "Astana"]
    
    @State private var destination = 1
    @State private var location = false
    @State private var secureVPN = ""
   
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }.onDelete(perform: deleteItems)
                }
                
                Section {
                    NavigationLink(destination:
                        CheckoutView()) {
                            Text("Place Order")
                    }
                }.disabled(order.items.isEmpty)
                
                
                // Done this section for myself)))
                Section(header: Text("Choose your city").font(.largeTitle)) {
                    Picker("Tell Your Destinations", selection: $destination) {
                        ForEach(0 ..< Self.destinations.count) {
                            Text(Self.destinations[$0])
                        }
                    }//.pickerStyle(SegmentedPickerStyle())
                    
                    Toggle(isOn: $location.animation(.spring())) {
                        Text("Do you want to show your location?")
                    }
                    
                    if location {
                        TextField("Enter yor secure VPN", text: $secureVPN)
                    }
                }
            }
            .navigationBarTitle("Order")
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static let order = Order()
    
    static var previews: some View {
        OrderView().environmentObject(order)
    }
}
