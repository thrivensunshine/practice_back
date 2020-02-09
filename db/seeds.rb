# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Employee.destroy_all 
Staff.destroy_all

data = JSON.parse(File.read("app/assets/i-d-iot-security-llc.json"))


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
  CHIEF = [
      'CEO',
      'CMO',
      'COO',
      'CTO',
      'CxO',
      'chief',
      'CHIEF'
  ]

  PREZ = [
      'President',
      'Co-founder',
      'VP',
      'vice',
      'VICE'
  ]

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

    def president(info)
        result = false
        employee_title = info["title"]
        PREZ.map do |title|
            if employee_title.include?(title)
                result = true
            end  
        end
        return result
    end

    def chief(info)
        result = false
        employee_title = info["title"]
        CHIEF.map do |title|
            if employee_title.include?(title)
                result = true
            end  
        end
        return result
    end


    def full_name(data)
        [data["profile"]["firstName"], data["profile"]["lastName"]].join(" ")
    end

    def format_quarter(i, which)
        date = i["dates"][which]
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

    def seed_it(data)
        
        data.map do |d|
            dateOne = format_date(d["dates"]["start_date"])
            dateTwo = format_date(d["dates"]["end_date"])
            Staff.create(
            name: full_name(d),
            position: d["title"],
            start_year: d["dates"]["start_date"],
            start_quarter: format_quarter(d, "start_date"),
            end_year: (d["dates"].include?("end_date") ? d["dates"]["end_date"] : "Current Employee"),
            end_quarter: format_quarter(d, "end_daterails"),
            board: boardMember(d),
            cheif: chief(d),
            president:president(d) ,
            int: 0)
        end 
    end

    seed_it(data)