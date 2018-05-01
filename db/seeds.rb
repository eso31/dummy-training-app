americaHermosillo =  "America/Hermosillo"

test_user = User.create :email => 'training-system@nearsoft1.com', :password => 'secret'

test_location = ClassLocation.create(:name => "Don Mina (HMO)", :email => "donmina@nearsoft.com", :timezone => americaHermosillo)

test_series = Series.create( name: "The Cookbook", description: "A good long lasting relationship with your client takes time and effort to build. But, the end result is totally worth it. What can you do to find those hidden needs? How can you keep your client happy without turning into a lapdog?" )

test_course = Course.create( title: "Training", description: "What kind of training can Nearsoft offer me? How do I ask for it?...", duration_in_minutes: 30, min_group_size: 1, max_group_size: 50, taught_by_user: test_user, series: test_series )

test_training_session = TrainingSession.create( title: "title-test", description: "desc-test", min_group_size: 1, max_group_size: 30, start_date: Time.now, url: "url", duration_in_minutes: 60, session_type: "ONLINE_CLASS", course: test_course, class_location: test_location )