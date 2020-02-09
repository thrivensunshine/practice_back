# class PostsController < ApplicationController
#   require "date"
  
#   # parse the file 
#   DATA = JSON.parse(File.read("app/assets/i-d-iot-security-llc.json"))

#   # declare the titles of board members to seperate from other employees 
#   JOB_TITLES = [
#     'CEO',
#     'CMO',
#     'COO',
#     'CTO',
#     'CxO',
#     'President',
#     'Board',
#     'Chief'
#   ]
  
#   # variable to hold Board members 
#   BOARD = []
#   XAXIS = []
#   # our data to send 
#     def index
#       results = {
#           :xaxis => x_axis,
#           :count => count,
#           :board => BOARD,
#           :employees => employees,
#           :bigBoss => bigBoss,
          
#       }

#       x_axis
#       count
#       BOARD
#       employees

#       render json: results

#   end

#   # get the employee count without board members
#   def count
#       DATA.count - BOARD.count
#   end

#   # get the board members and push into variable 
#   def bigBoss 
#     DATA.map do |d|
#       JOB_TITLES.map do |title|
#         if d["title"].include?(title)

#           BOARD.push( {
#            :name => full_name(d),
#            :title => d["title"],
#            :start => d["dates"]["start_date"],
#            :end => d["dates"].include?("end_date") ? d["dates"]["end_date"] : "Currently Working"
#           })
#         end
#       end
#     end
#   end

#   # filter data to get employee information needed 
#   def employees
#       results = []
#       DATA.map do |d|  

#           results.push(
#               :full_name => full_name(d),
#               :start_date => d["dates"]["start_date"],
#               :end_date => d["dates"].include?("end_date") ? d["dates"]["end_date"] : "Currently Working",
#               :position => d["title"],
#               :quarter => current_quarter(d["dates"]["start_date"])
#           )

#       end
#   end


# def current_quarter(date)
#   # to handle data with no entry
#     return "unknown" if date.nil?
    
#     start_date = format_date(date)
#     month = start_date[1]

#     quarters = {
#         :q1 => [1,2,3],
#         :q2 => [4,5,6],
#         :q3 => [7,8,9],
#         :q4 => [10,11,12]
#     }
#     quarters.each do |quarter, months|
#      return "No Month Given" if month == 00
#      next unless months.include?(month)
#        return quarter
#     end
# end

# def x_axis
#   xaxis = []
#   DATA.map do |d|
#   year = d["dates"]["start_date"].to_i
#      if  year != 0
#       xaxis.push("#{year} Q1","#{year} Q2","#{year} Q3","#{year} Q4" )
#      end
#   end
#   xaxis.uniq.sort
# end


#     # ~~~~~~~~~~~helper functions below~~~~~~~~~~~~~

#     # get full name 
#   def full_name(data)
#     [data["profile"]["firstName"], data["profile"]["lastName"]].join("")
#   end

#   #  format the date to integer 
#     def format_date(date)
#       date.split("-").map(&:to_i)
#   end
  

# end

