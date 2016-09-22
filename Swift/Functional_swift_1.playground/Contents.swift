//: Playground - noun: a place where people can play

import Foundation

typealias DistanceO = Double

struct PositionO {
    var x: Double
    var y: Double
}

extension PositionO {
    func inRange(range: DistanceO) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
}

extension PositionO {
    func minus(p: PositionO) -> PositionO {
        return PositionO(x: x - p.x, y: y - p.y)
    }
    var length: Double {
        return sqrt(x * x + y * y)
    }
    
}
struct ShipO {
    var position: PositionO
    var firingRange: DistanceO
    var unsafeRange: DistanceO
}

extension ShipO {
    func canEngageShipO(target: ShipO) -> Bool {
        let targetDistanceO = target.position.minus(position).length
        return targetDistanceO <= firingRange && targetDistanceO > unsafeRange
    }
}

extension ShipO {
    func canSafelyEngateShipO(target: ShipO, friendly: ShipO) -> Bool {
        let targetDistanceO = target.position.minus(position).length
        let friendlyDistanceO = target.position.minus(friendly.position).length
        return targetDistanceO < firingRange
            && targetDistanceO > unsafeRange
            && friendlyDistanceO > unsafeRange
    }
}

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}
extension Position {
    var length: Double {
        return sqrt(x * x + y * y)
    }
    var minus: Position -> Position {
        return { Position(x:$0.x-self.x, y: $0.y-self.y)}
    }
}
struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}
struct Region {
    var lookup: Position -> Bool
}
extension Region {
    init(circleRadius: Distance) {
        lookup = { $0.length <= circleRadius }
    }
    init(circleRadius: Distance, center: Position) {
        lookup = { $0.minus(center).length <= circleRadius}
    }
    init(loopInnerRadius: Distance, outerRadius: Distance, center: Position) {
        lookup = { $0.minus(center).length <= outerRadius && $0.minus(center).length > loopInnerRadius}
    }
    func shift(offset: Position) -> Region {
        return Region(lookup: { self.lookup($0.minus(offset))})
    }
    func invert() -> Region {
        return Region(lookup:{ !self.lookup($0)})
    }
    func intersection(region: Region) -> Region {
        return Region(lookup: { self.lookup($0) && region.lookup($0)})
    }
    func union(region: Region) -> Region {
        return Region(lookup: { self.lookup($0) || region.lookup($0)})
    }
    func difference(region: Region) -> Region {
        return Region(lookup: { self.lookup($0) && !region.lookup($0)})
    }
}

class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

extension Ship {
    var unsafeRegion: Region {
        return Region(circleRadius: unsafeRange, center: position)
    }
    var firingRegion: Region {
        return Region(circleRadius: firingRange, center: position)
    }
    var ownRegion: Region {
        return Region(loopInnerRadius: unsafeRange, outerRadius: firingRange, center: position)
    }
    func canSafelyEngageShip(target: Ship, friend: Ship) -> Bool {
        
        return self.ownRegion
            .difference(friend.unsafeRegion)
            .lookup(target.position)
    }
}