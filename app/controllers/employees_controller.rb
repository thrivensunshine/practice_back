class EmployeesController < ApplicationController
    BOARD = []
    DATA = JSON.parse(File.read("app/assets/i-d-iot-security-llc.json"))
    ALL = Employee.all 
    def index
        test_it
     
        @@employees = Employee.all 

        render json: @@employees

    end

    def test_it
    DATA.map do |i|
        # if i &&( i["dates"]["start_datve"][5] + i["dates"]["start_date"][5]) != "00"
        
        date = i["dates"]["start_date"]
        month = format_date(date)
        if month 
        ((month[1]/3).ceil) + 1
        end
    
    end
    end

    def format_quarter(i)
        date = i["dates"]["start_date"]
        month = format_date(date)
        if month 
        ((month[1]/3).ceil) + 1
        end
    end


    def format_date(date)
        if date
        month = (date[5]+date[6]).to_i
        day = (date[8] + date[9]).to_i
           if month != 0 && day != 0
            # Time.parse(date)
            date.split("-").map(&:to_i)
           end


         end
        end
         
        

end

