class Listing < ActiveRecord::Base
  enum category: {
    'apartment': 0,
    'terrace': 1,
    'bungalow': 2,
    'villa': 3
  }


  scope :sorted_by, lambda { |sort_option|
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^category/
    order("LOWER(listings.category) #{ direction }")
  when /^title/
    order("LOWER(listings.title) #{ direction }")
  when /^location/
    order("LOWER(listings.location) #{ direction }")
  when /^room_nums/
    order("LOWER(listings.room_nums) #{ direction }")
  when /^bathroom_nums/
    order("LOWER(listings.bathroom_nums) #{ direction }")
  else
    raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}

 filterrific(
  default_filter_params: { sorted_by: 'created_at_desc' },
  available_filters:[
    :category,
    :title,
    :location,
    :room_nums,
    :bathroom_nums
  ]
)

end
