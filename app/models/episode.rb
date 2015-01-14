class Episode < ActiveRecord::Base
  # Return array rather than string!
  def image_urls
    u = read_attribute(:image_urls)
    return [] if u.nil?
    u.split(';')
  end

  # Return array rather than string!
  def categories
    c = read_attribute(:categories)
    return [] if c.nil?
    c.split(',')
  end
end
