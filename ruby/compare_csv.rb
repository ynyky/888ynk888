require 'csv'
require 'byebug'

first_file= File.open('test.csv')
secound_file= File.open('test2.csv')
parsing_first= CSV.parse(first_file)
parsing_second= CSV.parse(secound_file)
g = (9.8 ** 2)
list_dinsoaurs= {}
parsing_first.each do |name, leg_length, stance|
    if stance == 'bipedal'
       # puts name
        parsing_second.each do |name_2, stride_length, diet|
            if name == name_2
                speed = ((stride_length.to_f / leg_length.to_f) - 1 )* Math.sqrt(((leg_length.to_f * g.to_f)))
                speed= speed.round(2)
                list_dinsoaurs.store(name, speed)
            end
        end
    end

end
list_dinsoaurs=list_dinsoaurs.sort_by{|k,v| v}.reverse
list_dinsoaurs = list_dinsoaurs.to_h
list_dinsoaurs.each do |k,v| puts k end