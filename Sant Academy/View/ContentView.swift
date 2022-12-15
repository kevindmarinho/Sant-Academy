//
//  ContentView.swift
//  Sant Academy
//
//  Created by kevin marinho on 12/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var capturedImage: UIImage? = nil
    @State private var isCustomCameraViewPresent = false
    @State var items : [Any] = []
    @State var sheet = false
    @State private var showingOptions = false
     
    var body: some View {
        ZStack{
            if capturedImage != nil {
                ZStack{
                    creenshot
                    Button(action: {
                        showingOptions = true
                    }, label: {
                        Image(systemName: "square.and.arrow.up")
                    }).confirmationDialog("", isPresented: $showingOptions, titleVisibility: .hidden){
                        
                        Button(action: {
                            guard let images = ImageRenderer(content: creenshot).uiImage else{ return }
                            items.removeAll()
                            items.append(images)
                            sheet.toggle()
                        }, label: {
                            Text("share")
                                .fontWeight(.heavy)
                        })
                        
                        Button("click to save"){
                            guard let image = ImageRenderer(content: creenshot).uiImage else{
                                return
                            }
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }
                    }
                 
                    VStack {
                        Spacer()
                        Button(action: {
                            isCustomCameraViewPresent.toggle()
                            
                        }, label: {
                                ZStack{
                                    Image(systemName: "arrow.triangle.2.circlepath.camera")
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }.padding(.bottom, 20)
                            })
                        .padding(.bottom)
                        .fullScreenCover(isPresented: $isCustomCameraViewPresent, content: {
                            CameraView(caturedImage: $capturedImage)
                        })
                    }
                    .sheet(isPresented: $sheet, content: {
                        ShareSheet(items: items)
                    })
                    .padding()
                }
            } else {
//                Image("mold2")
//                    .resizable()
//                Color(UIColor.systemBackground)
                CameraView(caturedImage: $capturedImage)
            }
        }
    }
    
    var creenshot: some View{
        ZStack{
            if let capturedImage = capturedImage {
                Image(uiImage: capturedImage)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
                Image("mold3")
                    .resizable()
            }else {
                //                Image("mold2")
                //                    .resizable()
                //                Color(UIColor.systemBackground)
                                CameraView(caturedImage: $capturedImage)
            }
        }
    }
}


struct ShareSheet: UIViewControllerRepresentable{
    
    var items : [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}


