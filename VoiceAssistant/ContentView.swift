//
//  ContentView.swift
//  VoiceAssistant
//
//  Created by Jor . on 19/03/2024.
//

import SwiftUI
import SiriWaveView

struct ContentView: View {
    @State var vm = VoiceAssistantViewModel()
    @State var isSysmbilAnimating = false
    var body: some View {
        VStack(spacing: 16) {
            Text("Voice Assistant")
                .font(.title2)
            
            Spacer()
            SiriWaveView()
                .power(power: vm.audioPower)
                .opacity(vm.siriWaveFormOpacity)
                .frame(height: 256)
                .overlay {overlayView}
            Spacer()
            
            switch vm.state {
            case .recordingSpeech: cancelRecordingButton
            case .playingSpeech:
                cancelButton
            case .processingSpeech:
                cancelButton
            default: EmptyView()
            }
        
            Picker("Select Voice", selection: $vm.selectedVoice) {
                ForEach(VoiceType.allCases, id: \.self){
                    Text($0.rawValue).id($0)
                }
            }
            .pickerStyle(.segmented)
            .disabled(!vm.isIdle)
            
            if case let .error(error) = vm.state {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
                    .font(.caption)
                    .lineLimit(2)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var overlayView: some View {
        switch vm.state {
        case .idle, .error:
            startCaptureButton
        case .processingSpeech:
            Image(systemName: "person.2.wave.2.fill")
                //.symbolEffect(.bounce.up.bylayer, options: repeating, value: isSysmbilAnimating)
                .offset(y: isSysmbilAnimating ? 35 : -35)
                .animation(.easeOut(duration: 4)
                    .repeatForever(), value: isSysmbilAnimating)
                .font(.system(size: 128))
                .onAppear { isSysmbilAnimating = true }
                .onDisappear { isSysmbilAnimating = false}
            
        default: EmptyView()
        }
    }
    
    var cancelRecordingButton: some View {
        Button(role: .destructive) {
            vm.cancelRecording()
        } label: {
            Image(systemName:"xmark.circle.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 44))
        }.buttonStyle(.borderless)
    }
    
    var startCaptureButton: some View {
        Button {
            vm.startCapturedAudio()
        } label: {
            Image(systemName: "mic.and.signal.meter.fill")
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 120))
        }
    }
    
    var cancelButton: some View {
        Button {
            vm.cancelProcessingTask()
        } label: {
            Image(systemName: "stop.circle.fill")
                .symbolRenderingMode(.monochrome)
                .foregroundStyle(.blue)
                .font(.system(size: 44))
        }.buttonStyle(.borderless)
    }
}

#Preview("Idle") {
    ContentView()
}

#Preview("Recording speech") {
    let vm = VoiceAssistantViewModel()
    vm.state = .recordingSpeech
    vm.audioPower = 0.25
    return ContentView(vm: vm)
}

#Preview("Processing speech") {
    let vm = VoiceAssistantViewModel()
    vm.state = .processingSpeech
    return ContentView(vm: vm)
}

#Preview("Playing speech") {
    let vm = VoiceAssistantViewModel()
    vm.state = .playingSpeech
    vm.audioPower = 0.3
    return ContentView(vm: vm)
}

#Preview("Error") {
    let vm = VoiceAssistantViewModel()
    vm.state = .error("An error has occured")
    return ContentView(vm: vm)
}


