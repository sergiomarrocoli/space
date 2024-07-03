class CatalogueObjectsController < ApplicationController
  def index
    @catalogue_objects = CatalogueObject.where.not(common_name: nil)

    geojson = {
      type: "FeatureCollection",
      features: @catalogue_objects.map do |object|
        {
          type: "Feature",
          geometry: {
            type: "Point",
            coordinates: [object.dec_decimal, object.ra_decimal]
          },
          properties: {
            name: object.name,
            object_type: object.object_type,
            ra: object.ra,
            dec: object.dec,
            constellation: object.constellation,
            common_name: object.common_name,
            identifiers: object.identifiers,
            surface_brightness: object.surface_brightness
          }
        }
      end
    }

    render json: geojson
  end
end
