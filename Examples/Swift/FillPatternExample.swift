import Mapbox

@objc(FillPatternExample_Swift)

class FillPattern_Swift: UIViewController, MGLMapViewDelegate {
    var coordinates: [CLLocationCoordinate2D]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: view.bounds)
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.styleURL = MGLStyle.darkStyleURL(withVersion: 9)
        
        // Set the map’s center coordinate and zoom level.
        mapView.setCenter(CLLocationCoordinate2D(latitude: 38.849534447, longitude: -77.039222717), zoomLevel: 8.5, animated: false)
        view.addSubview(mapView)
        
        mapView.delegate = self
        
        coordinates = circleCoordinates()
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        // Set the UIImage to be used for the fill pattern.
        var fillPatternImage: UIImage!
        fillPatternImage = UIImage(named: "stripe-pattern")
        
        // Add the fill pattern image to used by the style layer.
        style.setImage(fillPatternImage.withRenderingMode(.alwaysTemplate), forName: "stripe-pattern")
        
        // Create a shape source based off of a polygon object.
        let shape = MGLPolygon(coordinates: coordinates, count: UInt(coordinates.count))
        let source = MGLShapeSource(identifier: "circle", shape: shape, options: nil)
        style.addSource(source)
        
        // Create a style layer to be used with the shape source.
        let layer = MGLFillStyleLayer(identifier: "circle", source: source)
        
        // Set the fill pattern and opacity for the style layer. The MGLStyleValue
        // object is a generic container for a style attribute value. In this case,
        // it is a reference to the fillPatternImage.
        layer.fillPattern = MGLStyleValue<NSString>(rawValue: "stripe-pattern")
        layer.fillOpacity = MGLStyleValue(rawValue: 0.5)
        
        // Insert the pattern style layer below the layer contining city labels. If the
        // layer is not found, the style layer will be added above all other layers within the
        // Mapbox Dark style. NOTE: The "place-city-sm" layer is specific to the Mapbox Dark style.
        // Refer to the layers list in Mapbox Studio to confirm which layers are available for
        // use when working with a custom style.
        if let cityLabels = style.layer(withIdentifier: "place-city-sm") {
            style.insertLayer(layer, below: cityLabels)
        } else {
            style.addLayer(layer)
        }
    }
    
    func circleCoordinates() -> [CLLocationCoordinate2D] {
        return [
            (39.066563915, -77.039222717),
            (39.061806924, -76.981109643),
            (39.047745729, -76.925558969),
            (39.025000164, -76.875017152),
            (38.994572102, -76.831704529),
            (38.957800304, -76.797516310),
            (38.916300358, -76.773939386),
            (38.871892594, -76.761988660),
            (38.826521396, -76.762165426),
            (38.782169625, -76.774439122),
            (38.740771983, -76.798252610),
            (38.704131113, -76.832550084),
            (38.673839964, -76.875825757),
            (38.637233347, -76.981455461),
            (38.632504980, -77.039222717),
            (38.637233347, -77.096989973),
            (38.651213622, -77.152254627),
            (38.673839966, -77.202619678),
            (38.704131113, -77.245895351),
            (38.740771983, -77.280192824),
            (38.782169625, -77.304006313),
            (38.826521396, -77.316280008),
            (38.871892594, -77.316456775),
            (38.916300358, -77.304506049),
            (38.957800304, -77.280929125),
            (38.994572102, -77.246740905),
            (39.025000164, -77.203428283),
            (39.047745729, -77.152886465),
            (39.061806924, -77.097335791),
            (39.066563915, -77.039222717)
            ].map({CLLocationCoordinate2D(latitude: $0.0, longitude: $0.1)})
    }
}

