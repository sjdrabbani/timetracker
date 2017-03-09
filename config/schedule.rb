every :weekday, :at => '6:00 pm' do
  runner 'User.create_unannounced_leave'
end

every 1.year, at => 'December 31st 11:58pm' do
  runner 'LeaveTracker.update_leave_tracker_yearly'
end

every 1.year, at => 'January 1st 12:00am' do
  runner 'LeaveTracker.initialize_every_leave_with_new_year'
end
