//
//  AddMetaView.swift
//  CoreDataDos
//
//  Created by MAC on 06/08/22.
//

import SwiftUI

struct AddMetaView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var model = MetasViewModel()
    
    var body: some View {
        VStack {
            TextField("Titulo", text: $model.titulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Desc", text: $model.desc)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                model.saveData(context: context)
            }) {
                Text("Guardar")
            }
            Spacer()
        }
        .padding()
    }
}

