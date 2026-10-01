require_relative 'config/environment'
begin
  User.find_by(id: 1)
  puts "find_by(id: 1) works!"
rescue => e
  puts e.class
  puts e.message
  puts e.backtrace.join("\n")
end

begin
  ApplicationController.new.send(:session)
  puts "session works!"
rescue => e
  puts e.class
  puts e.message
  puts e.backtrace.join("\n")
end
