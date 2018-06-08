/*
See LICENSE folder for this sample’s licensing information.

Abstract:
iBeacon implementation for setting up at WWDC game room tables.
*/

import Foundation
import CoreLocation

private let regionUUID = UUID(uuidString: "53FA6CD3-DFE4-493C-8795-56E71D2DAEAF")!
private let regionId = "GameRoom"

struct GameTableLocation: Equatable, Hashable {
    typealias ProximityLocationId = Int
    let identifier: ProximityLocationId
    let name: String
    
    var hashValue: Int {
        return identifier.hashValue
    }
    
    private init(identifier: Int) {
        self.identifier = identifier
        self.name = "Table \(self.identifier)"
    }
    
    private static var locations: [ProximityLocationId: GameTableLocation] = [:]
    static func location(with identifier: ProximityLocationId) -> GameTableLocation {
        if let location = locations[identifier] {
            return location
        }
        
        let location = GameTableLocation(identifier: identifier)
        locations[identifier] = location
        return location
    }
    
    static func == (lhs: GameTableLocation, rhs: GameTableLocation) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension CLProximity: CustomStringConvertible {
    public var description: String {
        switch self {
        case .unknown:
            return "unknown"
        case .immediate:
            return "immediate"
        case .near:
            return "near"
        case .far:
            return "far"
        }
    }
}

protocol ProximityManagerDelegate: class {
    func proximityManager(_ manager: ProximityManager, didChange location: GameTableLocation?)
    func proximityManager(_ manager: ProximityManager, didChange authorization: Bool)
}

class ProximityManager: NSObject {
    static var shared = ProximityManager()

    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: regionUUID, identifier: regionId)
    var isAvailable: Bool {
        return CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
    }
    var isAuthorized: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways
    }
    
    var closestLocation: GameTableLocation?
    weak var delegate: ProximityManagerDelegate?
    
    override private init() {
        super.init()
        self.locationManager.delegate = self
        requestAuthorization()
    }

    func requestAuthorization() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func start() {
        guard isAvailable else { return }
        locationManager.startRangingBeacons(in: region)
    }
    
    func stop() {
        guard isAvailable else { return }
        locationManager.stopRangingBeacons(in: region)
    }
}

extension ProximityManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        // we want to filter out beacons that have unknown proximity
        let knownBeacons = beacons.filter { $0.proximity != CLProximity.unknown }
        if let beacon = knownBeacons.first {
            var location: GameTableLocation? = nil
            if beacon.proximity == .near || beacon.proximity == .immediate {
                location = GameTableLocation.location(with: beacon.minor.intValue)
            }
            
            if closestLocation != location {
                closestLocation = location
                delegate?.proximityManager(self, didChange: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, rangingBeaconsDidFailFor region: CLBeaconRegion, withError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if let delegate = delegate {
            delegate.proximityManager(self, didChange: self.isAuthorized)
        }
    }
}
