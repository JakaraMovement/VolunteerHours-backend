User.create([
	{
		first_name: 'David',
		last_name: 'Murphy',
		birthday: Time.now,
		phone: '555-324-4556',
		address: '123 Test Dr',
		city: 'Fresno',
		state: 'CA',
		zip_code: '93726',
		email: 'dmurphy@test.com',
		password: '123456',
		password_confirmation: '123456',
		gender: 'Male',
		parent_email: 'parent@test.com',
		parent_first_name: 'Test',
		parent_last_name: 'Parent',
		parent_phone: '555-455-5430',
		school_year: 'High School Freshman'
	},
	{
		first_name: 'Stephen',
		last_name: 'Curry',
		birthday: Time.now,
		phone: '555-324-4556',
		address: '345 Test Dr',
		city: 'San Jose',
		state: 'CA',
		zip_code: '95134',
		email: 'scurry@test.com',
		password: '123456',
		password_confirmation: '123456',
		gender: 'Male',
		parent_email: 'parent@test.com',
		parent_first_name: 'Test2',
		parent_last_name: 'Parent',
		parent_phone: '555-455-5430',
		school_year: 'High School Senior'
	},
	{
		first_name: 'Ajay',
		last_name: 'Singh',
		birthday: Time.now,
		phone: '555-324-4556',
		address: '345 Test Dr',
		city: 'San Jose',
		state: 'CA',
		zip_code: '95134',
		email: 'asingh@test.com',
		password: '123456',
		password_confirmation: '123456',
		admin: true,
		gender: 'Male',
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
		name: 'Sikholars',
		description: 'Description 1',
		venue: 'Robobank Arena',
		start_time: Time.now + 12.hours,
		end_time: Time.now + 14.hours,
		max_limit: 2,
		region_id: Region.first.id
	},
	{
		name: 'Misl Bay - Art Show',
		description: 'Description 2',
		venue: '1188 Murphy Ave San Jose, CA 95131',
		start_time: Time.now + 14.hours,
		end_time: Time.now + 16.hours,
		max_limit: 4,
		region_id: Region.last.id
	}
])
