User.create([
	{
		first_name: 'Test',
		last_name: 'User',
		birthday: Time.now,
		phone: '555-324-4556',
		address: '123 Test Dr',
		city: 'Fresno',
		state: 'CA',
		zip_code: '93726',
		email: 'test@drive.com',
		password: '123456',
		password_confirmation: '123456',
		gender: 'male',
		parent_email: 'parent@test.com',
		parent_first_name: 'Test',
		parent_last_name: 'Parent',
		parent_phone: '555-455-5430',
		school_year: 'High School Freshman'
	},
	{
		first_name: 'Test',
		last_name: 'User2',
		birthday: Time.now,
		phone: '555-324-4556',
		address: '345 Test Dr',
		city: 'San Jose',
		state: 'CA',
		zip_code: '95134',
		email: 'test2@drive.com',
		password: 'Qwerty.',
		password_confirmation: 'Qwerty.',
		gender: 'male',
		parent_email: 'parent@test.com',
		parent_first_name: 'Test2',
		parent_last_name: 'Parent',
		parent_phone: '555-455-5430',
		school_year: 'High School Senior'
	},
	{
		first_name: 'Test',
		last_name: 'User2',
		birthday: Time.now,
		phone: '555-324-4556',
		address: '345 Test Dr',
		city: 'San Jose',
		state: 'CA',
		zip_code: '95134',
		email: 'admin@admin.com',
		password: '123456',
		password_confirmation: '123456',
		admin: true,
		gender: 'male',
		parent_email: 'parent@test.com',
		parent_first_name: 'Test2',
		parent_last_name: 'Parent',
		parent_phone: '555-455-5430',
		school_year: 'High School Senior'
	}
])

regions = ['Bakersfield','Fresno','209','Sacramento','Yuba City','Bay Area','Southern California','Other']
regions.each {|region| Region.create(name: region)}

Event.create([
	{
		name: 'Event1',
		criteria: 'Criteria1',
		max_limit: 3,
		region_id: Region.first.id
	},
	{
		name: 'Event1',
		criteria: 'Criteria2',
		max_limit: 5,
		region_id: Region.last.id
	}
])

UserEvent.create([
	{user_id: User.first.id, event_id: Event.first.id},
	{user_id: User.last.id, event_id: Event.last.id}
])
