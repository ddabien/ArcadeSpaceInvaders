import ScreenSaver

// MARK: - Sprites (pixel arrays, 1=on 0=off)

private let spriteA: [[Int]] = [
    [0,0,1,0,0,0,0,0,1,0,0],
    [0,0,0,1,0,0,0,1,0,0,0],
    [0,0,1,1,1,1,1,1,1,0,0],
    [0,1,1,0,1,1,1,0,1,1,0],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,0,1,1,1,1,1,1,1,0,1],
    [1,0,1,0,0,0,0,0,1,0,1],
    [0,0,0,1,1,0,1,1,0,0,0],
]
private let spriteA2: [[Int]] = [
    [0,0,1,0,0,0,0,0,1,0,0],
    [1,0,0,1,0,0,0,1,0,0,1],
    [1,0,1,1,1,1,1,1,1,0,1],
    [1,1,1,0,1,1,1,0,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [0,1,1,1,1,1,1,1,1,1,0],
    [0,0,1,0,0,0,0,0,1,0,0],
    [0,1,0,0,0,0,0,0,0,1,0],
]
private let spriteB: [[Int]] = [
    [0,0,0,1,1,0,0,0],
    [0,0,1,1,1,1,0,0],
    [0,1,1,1,1,1,1,0],
    [1,1,0,1,1,0,1,1],
    [1,1,1,1,1,1,1,1],
    [0,1,0,1,1,0,1,0],
    [1,0,0,0,0,0,0,1],
    [0,1,0,0,0,0,1,0],
]
private let spriteB2: [[Int]] = [
    [0,0,0,1,1,0,0,0],
    [0,0,1,1,1,1,0,0],
    [0,1,1,1,1,1,1,0],
    [1,1,0,1,1,0,1,1],
    [1,1,1,1,1,1,1,1],
    [0,0,1,1,1,1,0,0],
    [0,1,0,0,0,0,1,0],
    [1,0,0,0,0,0,0,1],
]
private let spriteC: [[Int]] = [
    [0,0,0,1,1,1,0,0,0],
    [0,1,1,1,1,1,1,1,0],
    [1,1,1,1,1,1,1,1,1],
    [1,1,0,1,1,1,0,1,1],
    [1,1,1,1,1,1,1,1,1],
    [0,0,1,0,0,0,1,0,0],
    [0,1,0,1,0,1,0,1,0],
    [1,0,0,0,0,0,0,0,1],
]
private let spriteC2: [[Int]] = [
    [0,0,0,1,1,1,0,0,0],
    [0,1,1,1,1,1,1,1,0],
    [1,1,1,1,1,1,1,1,1],
    [1,1,0,1,1,1,0,1,1],
    [1,1,1,1,1,1,1,1,1],
    [0,0,1,0,0,0,1,0,0],
    [0,0,0,1,0,1,0,0,0],
    [0,0,1,0,0,0,1,0,0],
]
private let shipSprite: [[Int]] = [
    [0,0,0,0,0,1,0,0,0,0,0],
    [0,0,0,0,1,1,1,0,0,0,0],
    [0,0,0,0,1,1,1,0,0,0,0],
    [0,1,1,1,1,1,1,1,1,1,0],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1],
]
private let shieldBlock: [[Int]] = [
    [0,0,1,1,1,1,1,1,1,1,1,1,0,0],
    [0,1,1,1,1,1,1,1,1,1,1,1,1,0],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,0,0,0,0,0,0,0,0,1,1,1],
    [1,1,0,0,0,0,0,0,0,0,0,0,1,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,1],
]
private let ufoSprite: [[Int]] = [
    [0,0,0,0,0,1,1,1,1,0,0,0,0,0],
    [0,0,0,1,1,1,1,1,1,1,1,1,0,0],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [0,0,1,1,0,1,1,1,1,0,1,1,0,0],
    [0,0,0,0,1,1,1,1,1,1,0,0,0,0],
]

// MARK: - Colors
private let colorGreen   = NSColor(red: 0.30, green: 0.91, blue: 0.30, alpha: 1)
private let colorBlue    = NSColor(red: 0.48, green: 0.48, blue: 1.00, alpha: 1)
private let colorViolet  = NSColor(red: 0.60, green: 0.40, blue: 1.00, alpha: 1)
private let colorOrange  = NSColor(red: 1.00, green: 0.55, blue: 0.16, alpha: 1)
private let colorOrange2 = NSColor(red: 0.88, green: 0.36, blue: 0.00, alpha: 1)
private let colorYellow  = NSColor(red: 0.96, green: 0.82, blue: 0.13, alpha: 1)
private let colorShield  = NSColor(red: 0.00, green: 0.80, blue: 0.00, alpha: 1)
private let colorShip    = NSColor(red: 0.00, green: 1.00, blue: 0.00, alpha: 1)
private let colorBullet  = NSColor.white
private let colorInvBullet = NSColor.yellow

// MARK: - Game structs
private struct Invader { var col: Int; var row: Int; var alive: Bool }
private struct Bullet  { var x: CGFloat; var y: CGFloat; var vy: CGFloat }
private struct Shield  { var x: CGFloat; var y: CGFloat; var pixels: [[Int]] }
private struct Explosion { var x: CGFloat; var y: CGFloat; var t: Int; var color: NSColor }

// MARK: - ScreenSaverView
@objc(RetroInvadersView)
final class RetroInvadersView: ScreenSaverView {

    // game state
    private var sc: CGFloat = 4
    private var invaders: [Invader] = []
    private var bullets: [Bullet] = []
    private var invBullets: [Bullet] = []
    private var shields: [Shield] = []
    private var explosions: [Explosion] = []
    private var invX: CGFloat = 0, invY: CGFloat = 0, invDX: CGFloat = 1
    private var shipX: CGFloat = 0, shipY: CGFloat = 0, shipDir: CGFloat = 1
    private var ufoX: CGFloat = -200, ufoActive = false, ufoTimer = 0
    private var frameCount = 0, stepTimer = 0
    private var score = 0, highScore = 0, lives = 3
    private var gameOver = false
    private var restartDelay = 0

    private let COLS = 11, ROWS = 5

    override init?(frame frameRect: NSRect, isPreview: Bool) {
        super.init(frame: frameRect, isPreview: isPreview)
        animationTimeInterval = 1.0 / 30.0
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        animationTimeInterval = 1.0 / 30.0
        wantsLayer = true
        layer?.backgroundColor = NSColor.black.cgColor
    }

    override func startAnimation() {
        super.startAnimation()
        initGame()
    }

    override func animateOneFrame() {
        update()
        setNeedsDisplay(bounds)
    }

    override var isOpaque: Bool { true }

    // MARK: - Init
    private func initGame() {
        let W = bounds.width, H = bounds.height
        let scW = floor(W * 0.80 / CGFloat(COLS * 15))
        let scH = floor(H * 0.55 / CGFloat(ROWS * 14))
        sc = max(2, min(scW, scH))

        let totalW = CGFloat(COLS) * (sc * 11 + sc * 4) - sc * 4
        invX = floor((W - totalW) / 2)
        invY = floor(H * 0.08)
        invDX = sc

        invaders = (0..<ROWS).flatMap { r in (0..<COLS).map { c in Invader(col: c, row: r, alive: true) } }

        let shieldY = floor(H * 0.72)
        let sw = sc * 14
        let spacing = floor(W / 5)
        shields = (0..<4).map { i in
            Shield(x: spacing * CGFloat(i+1) - sw/2, y: shieldY,
                   pixels: shieldBlock.map { $0 })
        }

        shipX = floor(W / 2); shipY = floor(H * 0.86); shipDir = 1
        bullets = []; invBullets = []; explosions = []
        ufoX = -200; ufoActive = false; ufoTimer = 300 + Int.random(in: 0..<200)
        frameCount = 0; stepTimer = 0
        score = 0; lives = 3; gameOver = false; restartDelay = 0
    }

    // MARK: - Update
    private func update() {
        guard !gameOver else {
            restartDelay += 1
            if restartDelay > 90 { initGame() }
            return
        }
        let W = bounds.width, H = bounds.height
        frameCount += 1

        // ship
        shipX += sc * 1.5 * shipDir
        if shipX + sc*5.5 > W - sc*4 { shipDir = -1 }
        if shipX - sc*5.5 < sc*4     { shipDir =  1 }

        // auto shoot
        if frameCount % 55 == 0 && bullets.count < 3 {
            bullets.append(Bullet(x: shipX, y: shipY - sc*4, vy: -sc*5))
        }

        // ufo
        ufoTimer -= 1
        if ufoTimer <= 0 && !ufoActive {
            ufoActive = true; ufoX = -sc*16
            ufoTimer = 400 + Int.random(in: 0..<400)
        }
        if ufoActive { ufoX += sc*1.2; if ufoX > W+sc*16 { ufoActive = false } }

        // invader step
        stepTimer += 1
        let alive = invaders.filter { $0.alive }
        let spd = max(4, 45 - (55 - alive.count) / 2)
        if stepTimer >= spd {
            stepTimer = 0
            let totalW = CGFloat(COLS) * (sc*11 + sc*4) - sc*4
            let hitWall = (invDX > 0 && invX+totalW > W-sc*8) || (invDX < 0 && invX < sc*8)
            if hitWall { invDX = -invDX; invY += sc*6 } else { invX += invDX }
            if frameCount % 3 == 0 { invaderShoot(alive: alive) }
        }

        // player bullets — update position then check collisions
        for i in 0..<bullets.count { bullets[i].y += bullets[i].vy }
        bullets = bullets.filter { b in
            if b.y < 0 { return false }
            if checkShield(x: b.x, y: b.y) { return false }
            for j in 0..<invaders.count {
                guard invaders[j].alive else { continue }
                let pos = invPos(invaders[j])
                if b.x >= pos.x && b.x <= pos.x+sc*11 && b.y >= pos.y && b.y <= pos.y+sc*8 {
                    invaders[j].alive = false
                    let pts = invaders[j].row == 0 ? 30 : invaders[j].row <= 2 ? 20 : 10
                    score += pts; if score > highScore { highScore = score }
                    explosions.append(Explosion(x: pos.x+sc*5.5, y: pos.y+sc*4, t: 18, color: rowColor(invaders[j].row)))
                    return false
                }
            }
            if ufoActive && b.x >= ufoX-sc*7 && b.x <= ufoX+sc*7 && b.y < H*0.12 {
                ufoActive = false; score += 100; if score > highScore { highScore = score }
                explosions.append(Explosion(x: ufoX, y: H*0.05, t: 22, color: colorYellow))
                return false
            }
            return true
        }

        // invader bullets
        for i in 0..<invBullets.count {
            invBullets[i].x += CGFloat.random(in: -0.3...0.3) * sc
            invBullets[i].y += invBullets[i].vy
        }
        invBullets = invBullets.filter { b in
            if b.y > H { return false }
            if checkShield(x: b.x, y: b.y) { return false }
            let sx = shipX-sc*5.5, sy = shipY-sc*3.5
            if b.x >= sx && b.x <= sx+sc*11 && b.y >= sy && b.y <= sy+sc*7 {
                lives -= 1
                explosions.append(Explosion(x: shipX, y: shipY, t: 30, color: colorShip))
                if lives <= 0 { gameOver = true; restartDelay = 0 }
                return false
            }
            return true
        }

        explosions = explosions.compactMap { var e = $0; e.t -= 1; return e.t > 0 ? e : nil }

        // invaders reach bottom
        for inv in invaders where inv.alive {
            let pos = invPos(inv)
            if pos.y + sc*8 >= shipY - sc*4 { gameOver = true; restartDelay = 0; break }
        }
        // all dead
        if invaders.filter({ $0.alive }).isEmpty { initGame() }
    }

    private func invaderShoot(alive: [Invader]) {
        guard !alive.isEmpty else { return }
        let cols = Array(Set(alive.map { $0.col }))
        let col = cols.randomElement()!
        if let inv = alive.filter({ $0.col == col }).max(by: { $0.row < $1.row }) {
            let pos = invPos(inv)
            invBullets.append(Bullet(x: pos.x+sc*5.5, y: pos.y+sc*8,
                                     vy: sc*2 + CGFloat.random(in: 0..<sc)))
        }
    }

    private func invPos(_ inv: Invader) -> CGPoint {
        CGPoint(x: invX + CGFloat(inv.col) * (sc*11 + sc*4),
                y: invY + CGFloat(inv.row) * (sc*11 + sc*4) * 0.9)
    }

    @discardableResult
    private func checkShield(x: CGFloat, y: CGFloat) -> Bool {
        for i in 0..<shields.count {
            let sh = shields[i]
            let col = Int((x - sh.x) / sc), row = Int((y - sh.y) / sc)
            guard col >= 0, col < 14, row >= 0, row < 10 else { continue }
            guard shields[i].pixels[row][col] == 1 else { continue }
            for dr in -1...1 { for dc in -2...2 {
                let r2 = row+dr, c2 = col+dc
                if r2 >= 0 && r2 < 10 && c2 >= 0 && c2 < 14 { shields[i].pixels[r2][c2] = 0 }
            }}
            return true
        }
        return false
    }

    private func rowColor(_ row: Int) -> NSColor {
        switch row { case 0: return colorGreen; case 1: return colorBlue
            case 2: return colorViolet; case 3: return colorOrange; default: return colorOrange2 }
    }

    // MARK: - Draw
    override func draw(_ rect: NSRect) {
        let ctx = NSGraphicsContext.current!.cgContext
        let W = bounds.width, H = bounds.height
        let tick = (frameCount / 20) % 2

        // background
        ctx.setFillColor(NSColor.black.cgColor)
        ctx.fill(bounds)

        // invaders
        for inv in invaders where inv.alive {
            let pos = invPos(inv)
            let sp: [[Int]]
            switch inv.row {
            case 0: sp = tick == 0 ? spriteA  : spriteA2
            case 1,2: sp = tick == 0 ? spriteB : spriteB2
            default: sp = tick == 0 ? spriteC : spriteC2
            }
            drawSprite(ctx, sp, x: pos.x, y: pos.y, color: rowColor(inv.row))
        }

        // UFO
        if ufoActive {
            drawSprite(ctx, ufoSprite, x: ufoX - sc*7, y: H*0.04, color: colorYellow)
        }

        // shields
        ctx.setFillColor(colorShield.cgColor)
        for sh in shields {
            for r in 0..<sh.pixels.count { for c in 0..<sh.pixels[r].count {
                if sh.pixels[r][c] == 1 {
                    ctx.fill(CGRect(x: sh.x+CGFloat(c)*sc, y: sh.y+CGFloat(r)*sc, width: sc, height: sc))
                }
            }}
        }

        // ship
        if !gameOver || frameCount % 6 < 4 {
            drawSprite(ctx, shipSprite, x: shipX - sc*5.5, y: shipY - sc*3.5, color: colorShip)
        }

        // player bullets
        ctx.setFillColor(colorBullet.cgColor)
        for b in bullets {
            ctx.fill(CGRect(x: b.x - sc*0.5, y: b.y, width: sc, height: sc*4))
        }

        // invader bullets zigzag
        ctx.setFillColor(colorInvBullet.cgColor)
        for b in invBullets {
            let z = frameCount % 4 < 2 ? sc*0.5 : -sc*0.5
            ctx.fill(CGRect(x: b.x+z-sc*0.5, y: b.y,       width: sc, height: sc*3))
            ctx.fill(CGRect(x: b.x-z-sc*0.5, y: b.y+sc*1.5, width: sc, height: sc*2))
        }

        // explosions
        for e in explosions {
            let progress = CGFloat(e.t) / 30.0
            let r = (1 - progress) * sc * 12
            ctx.setStrokeColor(e.color.withAlphaComponent(progress).cgColor)
            ctx.setLineWidth(sc * 0.8)
            for i in 0..<8 {
                let angle = CGFloat(i) / 8.0 * .pi * 2
                let len = r * CGFloat.random(in: 0.5...1.0)
                ctx.move(to: CGPoint(x: e.x + cos(angle)*r*0.2, y: e.y + sin(angle)*r*0.2))
                ctx.addLine(to: CGPoint(x: e.x + cos(angle)*len, y: e.y + sin(angle)*len))
                ctx.strokePath()
            }
        }

        // HUD
        let fontSize = max(12, sc * 4)
        let attrs: [NSAttributedString.Key: Any] = [
            .font: NSFont.monospacedDigitSystemFont(ofSize: fontSize, weight: .bold),
            .foregroundColor: NSColor.white
        ]
        NSString(string: "SCORE  \(score)").draw(at: NSPoint(x: sc*3, y: H - sc*7), withAttributes: attrs)
        let hiStr = NSString(string: "HI  \(highScore)")
        let hiW = hiStr.size(withAttributes: attrs).width
        hiStr.draw(at: NSPoint(x: W - hiW - sc*3, y: H - sc*7), withAttributes: attrs)

        // lives
        for i in 0..<lives {
            drawSprite(ctx, shipSprite, x: sc*3 + CGFloat(i)*sc*14, y: sc*2, color: colorShip)
        }

        // bottom line
        ctx.setFillColor(colorShield.cgColor)
        ctx.fill(CGRect(x: 0, y: sc*1, width: W, height: sc*0.5))

        // scanlines
        ctx.setFillColor(CGColor(red: 0, green: 0, blue: 0, alpha: 0.07))
        var sy: CGFloat = 0
        while sy < H { ctx.fill(CGRect(x: 0, y: sy, width: W, height: 2)); sy += 4 }
    }

    private func drawSprite(_ ctx: CGContext, _ sprite: [[Int]], x: CGFloat, y: CGFloat, color: NSColor) {
        ctx.setFillColor(color.cgColor)
        for row in 0..<sprite.count { for col in 0..<sprite[row].count {
            if sprite[row][col] == 1 {
                ctx.fill(CGRect(x: floor(x + CGFloat(col)*sc), y: floor(y + CGFloat(row)*sc),
                                width: ceil(sc), height: ceil(sc)))
            }
        }}
    }
}
