//
//  Animator.swift
//  Utilities
//
//  Created by Stephen H. Gerstacker on 2019-12-10.
//  Copyright © 2019 Stephen H. Gerstacker. All rights reserved.
//
import AVFoundation
import Foundation

final public class Animator {
    
    public typealias DrawCallback = (CGContext) -> ()
    
    let width: Int
    let height: Int
    let frameRate: CMTime
    
    let colorSpace: CGColorSpace
    
    let writer: AVAssetWriter
    let writerInput: AVAssetWriterInput
    let writerAdaptor: AVAssetWriterInputPixelBufferAdaptor
    
    let writerQueue: DispatchQueue
    let writerCondition: NSCondition
    var writerObservation: NSKeyValueObservation!
    let writerSemaphore: DispatchSemaphore
    
    var currentFrameTime = CMTime(seconds: 0.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
    
    /**
     Initialize a new Animator with the given dimensions and frame rate.
     - Parameter width: The width of the canvas that is presented when drawing.
     - Parameter height: The height of the canvas that is presented when drawing.
     - Parameter frameRate: Supplied as a ratio, the frame rate the video will be produced at. For example, to achieve 30 FPS, you would supply `1.0 / 30.0`.
     - Parameter url: The file URL to store the resulting video in.
     - Parameter backPressure: The amount of draw that can be queued at one time before blocking. [Default = 16]
     */
    public init(width: Int, height: Int, frameRate: Double, url: URL, backPressure: Int = 16) {
        precondition(width % 2 == 0)
        precondition(height % 2 == 0)
        
        self.width      = width
        self.height     = height
        self.frameRate  = CMTime(seconds: frameRate, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        writerQueue     = DispatchQueue(label: "us.gerstacker.adventofcode.animator")
        writerCondition = NSCondition()
        writerSemaphore = DispatchSemaphore(value: backPressure)
        colorSpace      = CGColorSpaceCreateDeviceRGB()
        
        if FileManager.default.fileExists(atPath: url.path) {
            try! FileManager.default.removeItem(at: url)
        }
        
        writer = try! AVAssetWriter(url: url, fileType: .mov)
        
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.hevc,
            AVVideoWidthKey: NSNumber(value: width),
            AVVideoHeightKey: NSNumber(value: height),
        ]
        
        writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        
        let sourceAttributes: [String: Any] = [
            String(kCVPixelBufferPixelFormatTypeKey): NSNumber(value: kCVPixelFormatType_32BGRA)
        ]
        
        writerAdaptor = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: writerInput, sourcePixelBufferAttributes: sourceAttributes)
        
        writerObservation = writerInput.observe(\.isReadyForMoreMediaData, options: .new) { (_, change) in
            guard let isReady = change.newValue, isReady else {
                return
            }
            
            if isReady {
                self.writerCondition.lock()
                self.writerCondition.signal()
                self.writerCondition.unlock()
            }
        }
        
        assert(writer.canAdd(writerInput))
        writer.add(writerInput)
        
        guard writer.startWriting() else {
            let message = writer.error?.localizedDescription ?? "UNKNOWN"
            fatalError("Could not start writing: \(message)")
        }
        
        writer.startSession(atSourceTime: currentFrameTime)
    }
    
    public func complete() {
        writerQueue.sync {
            writerInput.markAsFinished()
        }
        
        let sema = DispatchSemaphore(value: 0)
        writer.finishWriting { sema.signal() }
        sema.wait()
        
        if writer.status == .failed {
            let message = self.writer.error?.localizedDescription ?? "unknown error"
            print("Failed to finish writing: \(message)")
        }
        
        writerObservation.invalidate()
    }
    
    public func draw(callback: DrawCallback) {
        guard let pool = writerAdaptor.pixelBufferPool else {
            fatalError("No pixel buffer pool to pull from")
        }
        
        var nextPixelBuffer: CVPixelBuffer? = nil
        CVPixelBufferPoolCreatePixelBuffer(kCFAllocatorDefault, pool, &nextPixelBuffer)
        
        guard let pixelBuffer = nextPixelBuffer else {
            fatalError("Failed to get next pixel buffer for drawing")
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer, [])
        let baseAddress = CVPixelBufferGetBaseAddress(pixelBuffer)
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        let stride = CVPixelBufferGetBytesPerRow(pixelBuffer)
        
        guard
            let context = CGContext(
                data: baseAddress,
                width: width,
                height: height,
                bitsPerComponent: 8,
                bytesPerRow: stride,
                space: colorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue + CGBitmapInfo.byteOrder32Little.rawValue)
            else {
                fatalError("Failed to create context")
        }
        
        context.translateBy(x: 0.0, y: CGFloat(height))
        context.scaleBy(x: 1.0, y: -1.0)
        
        callback(context)
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer, [])
        
        writerSemaphore.wait()
        
        writerQueue.async {
            self.writerCondition.lock()
            
            while !self.writerInput.isReadyForMoreMediaData {
                self.writerCondition.wait()
            }
            
            self.writerCondition.unlock()
            
            self.writerAdaptor.append(pixelBuffer, withPresentationTime: self.currentFrameTime)
            self.currentFrameTime = CMTimeAdd(self.currentFrameTime, self.frameRate)
            self.writerSemaphore.signal()
        }
    }
}
