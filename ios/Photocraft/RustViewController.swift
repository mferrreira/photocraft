import UIKit
import MetalKit

class RustViewController: UIViewController {
    var mtkView: MTKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mtkView = MTKView(frame: view.bounds)
        mtkView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mtkView.device = MTLCreateSystemDefaultDevice()
        mtkView.colorPixelFormat = .bgra8Unorm
        mtkView.depthStencilPixelFormat = .depth32Float
        view.addSubview(mtkView)
        
        // Call Rust entry point
        run_rust_app()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

@_cdecl("run_rust_app")
func run_rust_app() {
    // This will be called from Rust side
    // For now, let Rust handle the main loop
}
