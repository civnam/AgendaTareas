//
//  AddTareasView.swift
//  CoreDataDos
//
//  Created by MAC on 06/08/22.
//

import SwiftUI

struct AddTareasView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var model = TareasViewModel()
    var meta: Metas
    
    var body: some View {
        VStack {
            TextField("tarea", text: $model.tarea)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                model.saveData(context: context, meta: meta)
            }) {
                Text("Guardar")
            }
        }
        .padding()
    }
}
