output = %x{which vzlist 1> /dev/null && vzlist -H -a -o veid,hostname,status 2>&1}
if $?.exitstatus
  Facter.add('veids') do
    setcode do
      veid = []
      output.each{|line|
        veid.push(line.split(' ').reject{ |e| e.empty? }.join(':'))
      }
      veid.join(' ')
    end
  end
end
