module ApplicationHelper
	include Pagy::Frontend
	
	def sortable(column, title = nil)
		title ||= column.titleize
		css_class = column.eql?(sort_column) ? "current #{sort_direction}" : nil
		direction = column.eql?(sort_column) && sort_direction == 'asc' ? 'desc' : 'asc'
		link_to title, {sort: column, direction: direction}, {class: css_class}
	end

	def table_name
		params[:controller].split('/').last
	end

  def sort_column
  	model = table_name.singularize.camelize.constantize
    if %w(regions.name).include?(params[:sort]) || model.column_names.include?(params[:sort])
      params[:sort]
    else
    	if table_name.eql?('events') || table_name.eql?('regions')
    		"#{table_name}.name"
    	elsif table_name.eql?('users')
    		"#{table_name}.first_name, #{table_name}.last_name" 
    	elsif table_name.eql?('volunteer_hours')
    		if params[:sort]&.include?('users.first_name')
    			'users.first_name, users.last_name'
    		elsif params[:sort]&.eql?('events.name')
    			'events.name'
    		else
    			"#{table_name}.status"
    		end
    	end
    end
  end

  def sort_direction
  	%w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def sort_by_multiple_columns
  	sort_items = sort_column.split(',')
  	return_str = ''
  	if sort_items.length > 1
  		sort_items.each_with_index do |item, i|
  			return_str += "#{item} #{sort_direction}"
  			return_str += ", " if i < sort_items.length - 1
  		end
  		return_str
  	else
  		"#{sort_column} #{sort_direction}"
  	end
  end

	def format_date(date)
		date&.strftime("%B %d, %Y")
	end

	def format_time(date)
		date&.strftime("%l:%M %P")
	end
end
