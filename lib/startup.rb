require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        return @salaries.keys.include?(title)
    end

    def >(startup)
        return self.funding > startup.funding
    end

    def hire(string, title)
        if valid_title?(title)
            newEmp = Employee.new(string, title)
            @employees << newEmp
        else
            raise "invalid title"
        end
    end

    def size
        return @employees.length
    end

    def pay_employee(employeeInstance)
        pay = salaries[employeeInstance.title]
        if @funding > pay
            employeeInstance.pay(pay)
            @funding -= pay
        else
            raise 'not enough funding'
        end
    end

    def payday
        @employees.each do |emp|
            pay_employee(emp)
        end
    end

    def average_salary
        avg = 0
        count = 0
        @employees.each do |emp|
            avg += @salaries[emp.title]
            count += 1
        end
        return avg/count
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.keys.each do |title|
            if @salaries.include?(title) == false
                @salaries[title] = startup.salaries[title]
            end
        end
        startup.employees.each do |emp|
            @employees << emp
        end
        startup.close
    end




end
