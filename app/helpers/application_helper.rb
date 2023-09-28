module ApplicationHelper


  def use_prefix(uri)
    uri = uri.value if uri.class != String

    uri.gsub("http://schema.org/","schema:")
      .gsub("http://kg.artsdata.ca/resource/","")
      .gsub("http://kg.footlight.io/resource/","footlight:")
  end
end
