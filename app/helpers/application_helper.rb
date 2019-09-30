module ApplicationHelper
	def format_date(date)
		date&.strftime("%B %d, %Y")
	end
	def format_time(date)
		date&.strftime("%I:%M %P")
	end
end
