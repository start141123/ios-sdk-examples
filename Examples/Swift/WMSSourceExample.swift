
import Mapbox

@objc(WMSSourceExample_Swift)

class WMSSourceExample: UIViewController, MGLMapViewDelegate {
    var items : [UIColor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.lightStyleURL(withVersion: 9))
        mapView.delegate = self
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.6892, longitude: -74.5447), zoomLevel: 8, animated: false)
        view.addSubview(mapView)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
//        let url = https://geodata.state.nj.us/imagerywms/Natural2015?bbox={bbox-epsg-3857}&format=image/png&service=WMS&version=1.1.1&request=GetMap&srs=EPSG:3857&width=256&height=256&layers=Natural2015
        
        let source = MGLRasterSource(identifier: "raster-layer", tileURLTemplates: ["https://idpgis.ncep.noaa.gov/arcgis/services/NWS_Observations/radar_base_reflectivity/MapServer/WMSServer"], options: nil)
        style.addSource(source)
        let layer = MGLRasterStyleLayer(identifier: "raster-layer", source: source)
        let symbolLayer = style.layer(withIdentifier: "admin-3-4-boundaries")
        style.insertLayer(layer, below: symbolLayer!)
    }

}
