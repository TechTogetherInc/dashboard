namespace :admissions do
  desc "Accept or flag student applications"
  task accept_now: :environment do

    list_of_users = User.all

    flagged_count = 0
    accepted_count = 0
    counter = 0

    list_of_users.each do |user|
      unless user.event_application.nil?
        app = user.event_application

        # Only consider accepting people that are undecided
        if app.application_status == 'undecided'

          # Get rejected if you graduated early or left shit empty on the application.
          if app.university == 'N/A' or app.major == 'N/A' or app.grad_year == '2016' or app.grad_year == '2015' or app.grad_year == '2014'
            flagged_count += 1
            counter += 1
            next
          end

          accepted_count += 1

        if counter >= 600
          break
        end

        end #End of undecided status check
      end #End of event application check
    end #End of all users loop


    puts "Flagged Applications: #{flagged_count}"
    puts "Accepted Applications: #{accepted_count}"

    puts "Total Applications Considered: #{flagged_count+accepted_count}"
  end

end