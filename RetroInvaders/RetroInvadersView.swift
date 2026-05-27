// RetroInvadersView.swift
// RetroInvaders screensaver — WKWebView con HTML embebido como string
//
// ARQUITECTURA: el HTML del juego se carga como loadHTMLString() en vez de
// loadFileURL(), lo que evita los problemas de sandbox de legacyScreenSaver.appex
// en macOS Sonoma y Sequoia (14+/15+) donde file:// URLs fallan silenciosamente.
//
// Compatible: macOS 12+ — Universal Binary (arm64 + x86_64)

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
        os_log("init isPreview=%{public}d", log: log, type: .info, isPreview)
        setupWebView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupWebView()
    }

    // MARK: - Setup
    private func setupWebView() {
        let config = WKWebViewConfiguration()

        // Necesario para Canvas 2D y requestAnimationFrame
        let prefs = WKPreferences()
        prefs.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.preferences = prefs

        let wv = WKWebView(frame: bounds, configuration: config)
        wv.autoresizingMask = [.width, .height]
        wv.translatesAutoresizingMaskIntoConstraints = false

        // Fondo negro, sin chrome del browser
        wv.setValue(false, forKey: "drawsBackground")
        if #available(macOS 12.0, *) {
            wv.underPageBackgroundColor = .black
        }
        wv.allowsMagnification = false

        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
        addSubview(wv)

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
        webView?.evaluateJavaScript("(typeof lastTime !== 'undefined') && (lastTime = -9e9)", completionHandler: nil)
        super.stopAnimation()
    }

    override func animateOneFrame() {
        // requestAnimationFrame dentro del HTML maneja el loop — nada que hacer acá
    }

    // MARK: - Loading
    private func loadGameIfNeeded() {
        guard !hasLoaded else { return }
        guard let wv = webView else { return }

        // Cargar HTML como string — evita todos los problemas de sandbox file://
        // en legacyScreenSaver.appex en macOS Sonoma/Sequoia
        wv.loadHTMLString(RetroInvadersView.gameHTML, baseURL: nil)
        hasLoaded = true
        os_log("loadHTMLString executed", log: log, type: .info)
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

    // MARK: - Deinit
    deinit {
        webView?.stopLoading()
        webView?.removeFromSuperview()
        os_log("deinit", log: log, type: .info)
    }
}
