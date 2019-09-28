module EventsHelper
	def event_image_or_default_url(event)
		if event.event_image.attached?
			url_for(event.event_image)
		else
			image_url('events/event-placeholder.jpg')
		end
	end
end