import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static targets = ["map"]

  connect() {
    this.initializeMap()
    this.fetchAndAddGeoJSON()
  }

  initializeMap() {
    this.map = L.map(this.mapTarget).setView([51.505, -0.09], 13)
    this.mapTarget.style.backgroundColor = 'black'
  }

  async fetchAndAddGeoJSON() {
    try {
      const response = await fetch('/catalogue_objects')
      if (!response.ok) {
        throw new Error('Network response was not ok')
      }
      const data = await response.json()
      const geoJsonLayer = L.geoJSON(data, {
        pointToLayer: function (feature, latlng) {
          return L.circleMarker(latlng, {
            radius: 5,
            fillColor: "#f2ec99",
            color: "#000",
            weight: 1,
            opacity: 1,
            fillOpacity: 0.8
          });
        }      
      }).bindPopup(function (layer) {
          return layer.feature.properties.common_name;
      }).addTo(this.map);
      this.map.fitBounds(geoJsonLayer.getBounds())
    } catch (error) {
      console.error('Error fetching GeoJSON:', error)
    }
  }
}
