//
//  FotoView.swift
//  CoreDataDos
//
//  Created by MAC on 06/08/22.
//

import SwiftUI

struct FotoView: View {
    
    @Environment(\.managedObjectContext) var context
    //@FetchRequest(entity: Tareas.entity(), sortDescriptors: []) var tareas: FetchedResults<Tareas>
    
    var tarea: Tareas
    var fotos: FetchRequest<Fotos>
    init(tarea: Tareas) {
        self.tarea = tarea
        fotos = FetchRequest<Fotos>(entity: Fotos.entity(), sortDescriptors: [], predicate: NSPredicate(format: "idTarea == %@", tarea.id!))
    }
    
    @State private var imageData : Data = .init(capacity: 0)
    @State private var mostrarMenu = false
    @State private var imagePicker = false
    @State private var source : UIImagePickerController.SourceType = .camera
    
    let gridItem: [GridItem] = Array(repeating: .init(.flexible(maximum: 100)), count: 3)
    
    func save(imagen: Data) {
        let newFoto = Fotos(context: context)
        newFoto.foto = imagen
        newFoto.idTarea = tarea.id
        tarea.mutableSetValue(forKey: "relationToFotos").add(newFoto)
        
        do {
            try context.save()
            print("Guardo foto")
        } catch let error as NSError {
            print("No guardo foto", error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: ImagePicker(show: self.$imagePicker, image: self.$imageData, source: self.source), isActive: self.$imagePicker) {
                    Text("")
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
                ScrollView() {
                    LazyVGrid(columns: gridItem, spacing: 10) {
                        ForEach(fotos.wrappedValue) { foto in
                            Image(uiImage: UIImage(data: foto.foto ?? Data())!)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
                
                
                HStack(alignment: .center, spacing: 60) {
                    
                    Button(action:{
                        self.mostrarMenu.toggle()
                    }){
                        Image(systemName: "camera")
                    }.actionSheet(isPresented: self.$mostrarMenu) {
                        ActionSheet(title: Text("Menu"), message: Text("Selecciona una opción"), buttons: [
                            .default(Text("Camara"), action: {
                                self.source = .camera
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Libreria"), action: {
                                self.source = .photoLibrary
                                self.imagePicker.toggle()
                            }),
                            .default(Text("Cancelar"))
                        ])
                    }
                    
                    Button(action: {
                        save(imagen: imageData)
                    }) {
                        Text("Guardar Imagen")
                    }

                }
            }
        }
    }
}



