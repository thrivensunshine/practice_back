class PeopleController < ApplicationController

    DATA = JSON.parse(File.read("app/assets/i-d-iot-security-llc.json"))
    ALL = []
    EMPLOYEES = []
    BOARD = []
    XAXIS = []
    LASTDAY = []
    WORKING = {}
    CHECK = []
    # COUNT = 0


    JOB_TITLES = [
        'CEO',
        'CMO',
        'COO',
        'CTO',
        'CxO',
        'President',
        'Board',
        'Chief',
        'VP',
        'Co-Founder'
      ]

    def index
      
        fill_data
        x_axis
        execute_data
        array_it
        years_workin
        # start_end      
        results = {
            # :xaxis => x_axis,
            :years_working => CHECK,
            :board => BOARD,
            # :check => test_it,
            :employees => EMPLOYEES
        }

        render json: DATA
        
    end


    def seperate_board
        if BOARD.count == 0
        ALL.map do |i|
            if i[4] == true
                BOARD.push(i)
            end
            end
        end

        if EMPLOYEES.count == 0
            ALL.map do |i|
                if i[4] == false
                    EMPLOYEES.push(i)
                end
                end
            end   
    end

    def fill_data 
       
        name = ""
        position = ""
        start = ""
        end_d = ""
        board = ""
     

        DATA.map do |d|
  
            name = full_name(d)
            position = d["title"]
            start = d["dates"]["start_date"]
            end_d = d["dates"].include?("end_date") ? d["dates"]["end_date"] : "Current Employee"
            board = boardMember(d)
          
                ALL.push([name,position,start,end_d,board])
            
        end
        
    end



    def boardMember(info)
        result = false
        employee_title = info["title"]
        JOB_TITLES.map do |title|
            if employee_title.include?(title)
                result = true
            end  
        end
        return result
    end
    
    def years_workin
        count_dates = []
        sorted =[]
        working_people = Hash.new(0)
        current_year = LASTDAY[0][0].to_i
        current_quarter = 4

        EMPLOYEES.map do |d|
        
            start_d = format_date(d[2])
            if start_d
            start_year = start_d[0]
            start_quarter =(((start_d[1])/3).ceil) + 1
            end
            end_d = d[3] == "Current Employee" ? current_year : format_date(d[3])
            if end_d
            end_year = end_d == current_year ? current_year : end_d[0]
            end_quarter = d[3] == "Current Employee" ? current_quarter : (((end_d[1])/3).ceil) + 1
            end

            if end_year && start_year
          while end_year >= start_year && end_quarter
            count_dates.unshift("#{end_year} Q#{end_quarter-3}","#{end_year} Q#{end_quarter-2}", "#{end_year} Q#{end_quarter-1}","#{end_year} Q#{end_quarter}" )
            end_year -= 1

          end
        end
        end
        sorted = count_dates.sort

       return sorted.each_with_object(Hash.new(0))  do |i,e| 
        if !i.include?("-") && i.last != "0"
        e[i] +=1 
        end
       end
    end

    def array_it
       
        years_workin.map do |i|

            
            CHECK.push(i)
            CHECK.sort
        end
    
       
    end

  
    # def start_end
    #     result = Hash.new(0)

    #     years_workin.map do |i,e|
    #         EMPLOYEES.map do |d|
    #             # year = d[2][0]+d[2][1]+d[2][2]+d[2][3]
    #             # month = d[2][5]+d[2][6]
    #             # print "\n ----- \n"
    #             # print i
    #             # print "\n ----- \n"
                
    #         end
            
    #             end
        
    # end

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

    # def start_dat
    #     count_dates = []
    #     sorted =[]
    #     working_people = Hash.new(0)
    #     current_year = LASTDAY[0][0].to_i
    #     current_quarter = 4

    #     EMPLOYEES.map do |d|
        
    #         start_d = format_date(d[2])
    #         if start_d
    #         start_year = start_d[0]
    #         start_quarter =(((start_d[1])/3).ceil) + 1
    #         endcd 
    #         end_d = d[3] == "Current Employee" ? current_year : format_date(d[3])
    #         if end_d
    #         end_year = end_d == current_year ? current_year : end_d[0]
    #         end_quarter = d[3] == "Current Employee" ? current_quarter : (((end_d[1])/3).ceil) + 1
    #         end

    #         if start_year
    #             count_dates.unshift("#{start_year}")
    #     #   while end_year >= start_year && end_quarter
    #     #     count_dates.unshift("#{end_year} Q#{end_quarter-3}","#{end_year} Q#{end_quarter-2}", "#{end_year} Q#{end_quarter-1}","#{end_year} Q#{end_quarter}" )
    #     #     end_year -= 1

    #     #   end
    #     end
    #     end
    #     sorted = count_dates.sort

    #    return sorted.each_with_object(Hash.new(0))  do |i,e| 
    #     if !i.include?("-") && i.last != "0"
    #     e[i] +=1 
    #     end
    #    end
    # end

    def full_name(data)
        [data["profile"]["firstName"], data["profile"]["lastName"]].join(" ")
      end



    def x_axis
        xaxis = []
        check = ""
        DATA.map do |d|
        year = d["dates"]["start_date"].to_i
        if  year != 0
            xaxis.push("#{year} Q1","#{year} Q2","#{year} Q3","#{year} Q4" )
        end
        end
       
        final = xaxis.uniq.sort
        LASTDAY.push(final.last.split(" "))
        final
    end
    

    def execute_data

        seperate_board

    end




end

