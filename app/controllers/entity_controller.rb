class EntityController < ApplicationController
  # Show an entity's asserted statements
  # /entity?uri=
  def show
    uri = params[:uri] ||= "K1-3"
    uri = "http://kg.artsdata.ca/resource/#{uri}"if uri.starts_with?("K")

    if !uri.start_with?("http")
      flash.alert = "Not an Artsdata ID or URI."
      redirect_to root_path
    end
   
    @entity = Entity.new(entity_uri: uri)
    @entity.load_graph
    @entity.replace_blank_nodes # first level
    @entity.replace_blank_nodes # second level
  #  @entity.load_shacl_into_graph("shacl_artsdata.ttl") if @entity.graph.count > 0
  end

  # show all statements from all sources
  # including claimed statements from other sources that are not endorsed (quoted only)
  # /entity/expand?subject=[canonical URI]&predicate=[canonical URI]&predicate_hash=[predicate.hash]
  def expand
    uri = params[:subject]
    @predicate = RDF::URI(params[:predicate])
    @predicate_hash = params[:predicate_hash]
    @entity = Entity.new(entity_uri: uri)
    @entity.expand_entity_property(predicate: @predicate)
  end
 
end
