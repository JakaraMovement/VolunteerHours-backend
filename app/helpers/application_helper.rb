module ApplicationHelper
	include Pagy::Frontend
	
	def format_date(date)
		date&.strftime("%B %d, %Y")
	end
	def format_time(date)
		date&.strftime("%l:%M %P")
	end
end
