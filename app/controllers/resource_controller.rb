class ResourceController < ApplicationController

  # Do content negotiation
  # Treat entire URI not only /resource/K...
  # Should process http://kg.artsdata.ca/databus and /shacl and /ontology
  # Use request header 'Accept'
  # TODO: Try to replace this with rack/content_netgotiation
  def show
    uri = "http://kg.artsdata.ca" + request.path

    format = :html
    format = :rdf if request.headers['Accept'].include?('application/rdf+xml')
    format = :jsonld if request.headers['Accept'].include?('application/ld+json')
    format = :ttl if request.headers['Accept'].include?('text/turtle')
    
    redirect_to entity_path(uri: uri, format: format), status: 303

  end
end