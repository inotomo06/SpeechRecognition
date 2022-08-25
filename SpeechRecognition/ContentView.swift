//
//  ContentView.swift
//  SpeechRecognition
//
//  Created by cmStudent on 2022/03/21.
//



import SwiftUI
import Speech
import AVFoundation

struct ContentView: View {
    
    @ObservedObject private var speechRecorder = SpeechRecorder()
    @State var showingAlert = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Spacer()
                Button {
                    if(AVCaptureDevice.authorizationStatus(for: AVMediaType.audio) == .authorized &&
                       SFSpeechRecognizer.authorizationStatus() == .authorized) {
                        showingAlert = false
                        speechRecorder.toggleRecording()
                        
                        if !speechRecorder.audioRunning {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                
                            }
                        }
                    }
                    else{
                        showingAlert = true
                    }
                } label: {
                    if !speechRecorder.audioRunning {
                        Text("スピーチ開始")
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1))
                    } else {
                        Text("スピーチ終了")
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.red, lineWidth: 1))
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("マイクの使用または音声の認識が許可されていません"))
                }
                Spacer()
            }
            Text(speechRecorder.audioText)
        }
        .onAppear {
            AVCaptureDevice.requestAccess(for: AVMediaType.audio) { granted in
                OperationQueue.main.addOperation {
                    
                }
            }
            SFSpeechRecognizer.requestAuthorization { status in
                OperationQueue.main.addOperation {
                    //switch status {
                    //    case .authorized:
                    //
                    //    default:
                    //
                    //}
                }
            }
        }
        .padding(.vertical)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
