//
//  Home.swift
//  CoreDataDos
//
//  Created by MAC on 06/08/22.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Metas.entity(), sortDescriptors: []) var metas: FetchedResults<Metas>
    @ObservedObject var model = MetasViewModel()
    @State private var  buscar = ""
    @State private var isDark = true
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $buscar)
                List {
                    ForEach(metas.filter {
                        buscar.isEmpty ? true : $0.titulo!.lowercased().contains(buscar.lowercased())
                    }) { meta in
                        NavigationLink(destination: TareasView(meta: meta)) {
                            VStack(alignment: .leading) {
                                Text(meta.titulo ?? "").font(.title)
                                Text(meta.desc ?? "").font(.headline)
                            }
                        }
                    }
                    .onDelete(perform: { (IndexSet) in
                        let borrarMeta = metas[IndexSet.first!]
                        model.deleteData(item: borrarMeta, context: context)
                    })
                }
                NavigationLink(destination: AddMetaView()) {
                    Image(systemName: "note")
                }
            }
            .navigationTitle("Tareas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    isDark.toggle()
                } label: {
                    Label("", systemImage: isDark ? "lightbulb.fill" : "lightbulb")
                }
            }
        }
        .environment(\.colorScheme, isDark ? .dark : .light)
    }
}

