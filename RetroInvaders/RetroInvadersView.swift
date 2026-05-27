// RetroInvadersView.swift
// RetroInvaders screensaver — WKWebView rendering the Canvas game
// Compatible: macOS 12+ (Monterey and later)
// Architecture: arm64 + x86_64 (Universal)

import ScreenSaver
import WebKit
import os.log

private let log = OSLog(subsystem: "com.operiasuite.RetroInvaders", category: "ScreenSaver")

@objc(RetroInvadersView)
final class RetroInvadersView: ScreenSaverView {

    // MARK: - Properties

    private var webView: WKWebView?
    private var hasLoaded = false

    // MARK: - Init

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        os_log("init: isPreview=%{public}d frame=%{public}@",
               log: log, type: .info, isPreview, NSStringFromRect(frame))
        setupWebView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWebView()
    }

    // MARK: - Setup

    private func setupWebView() {
        // WKWebView configuration — minimal, no networking needed
        let config = WKWebViewConfiguration()
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")

        // Suppress JavaScript alerts/confirms in screensaver context
        let userContentController = WKUserContentController()
        config.userContentController = userContentController

        let wv = WKWebView(frame: bounds, configuration: config)
        wv.autoresizingMask = [.width, .height]
        wv.translatesAutoresizingMaskIntoConstraints = false

        // Transparent background so macOS can composite it
        wv.setValue(false, forKey: "drawsBackground")
        if #available(macOS 12.0, *) {
            wv.underPageBackgroundColor = .clear
        }

        // Disable user interactions — it's a screensaver
        wv.allowsMagnification = false

        // Layer-backed for smooth rendering
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor

        addSubview(wv)

        // Full-frame constraints
        NSLayoutConstraint.activate([
            wv.leadingAnchor.constraint(equalTo: leadingAnchor),
            wv.trailingAnchor.constraint(equalTo: trailingAnchor),
            wv.topAnchor.constraint(equalTo: topAnchor),
            wv.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        self.webView = wv
    }

    // MARK: - ScreenSaverView lifecycle

    override func startAnimation() {
        super.startAnimation()
        os_log("startAnimation", log: log, type: .info)
        loadGameIfNeeded()
    }

    override func stopAnimation() {
        os_log("stopAnimation", log: log, type: .info)
        // Pause the JS loop to release CPU when not visible
        webView?.evaluateJavaScript("document.hidden || (typeof lastT !== 'undefined' && (lastT = -9e9))", completionHandler: nil)
        super.stopAnimation()
    }

    override func animateOneFrame() {
        // Animation is driven by requestAnimationFrame inside the HTML — nothing to do here.
        // We keep animationTimeInterval at its default so the ScreenSaver framework
        // doesn't think we're idle.
    }

    // MARK: - Loading

    private func loadGameIfNeeded() {
        guard !hasLoaded else { return }
        guard let wv = webView else { return }

        // Locate game.html inside the bundle
        guard let url = bundle().url(forResource: "game", withExtension: "html") else {
            os_log("game.html not found in bundle", log: log, type: .error)
            return
        }

        os_log("Loading game from: %{public}@", log: log, type: .info, url.path)

        // Load with bundle base URL so relative resources resolve correctly
        wv.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        hasLoaded = true
    }

    // MARK: - Layout

    override func resizeSubviews(withOldSize oldSize: NSSize) {
        super.resizeSubviews(withOldSize: oldSize)
        webView?.frame = bounds
    }

    override func setFrameSize(_ newSize: NSSize) {
        super.setFrameSize(newSize)
        webView?.frame = bounds
    }

    // MARK: - Utilities

    private func bundle() -> Bundle {
        return Bundle(for: type(of: self))
    }

    // MARK: - Deinit

    deinit {
        webView?.stopLoading()
        webView?.removeFromSuperview()
        os_log("deinit", log: log, type: .info)
    }
}
