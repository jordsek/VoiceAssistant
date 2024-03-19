//
//  viewModel.swift
//  VoiceAssistant
//
//  Created by Jor . on 19/03/2024.
//
import AVFoundation
import Observation
import XCAOpenAIClient
import Foundation

@Observable
class VoiceAssistantViewModel: NSObject {
    
    let client = OpenAIClient(apiKey: "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")
    
    var selectedVoice = VoiceType.alloy
    var state = VoiceChatState.idle {
        didSet {print(state)}
    }
    
    var isIdle: Bool {
        if case .idle = state {
            return true
        }
        return false
    }
    var audioPower = 0.0
    var siriWaveFormOpacity: CGFloat {
        switch state {
        case .recordingSpeech, .playingSpeech: return 1
        default: return 0
        }
    }
    
    func startCapturedAudio(){
        
    }
    
    func  cancelRecording() {
        
    }
    
    func cancelProcessingTask() {
        
    }
}
