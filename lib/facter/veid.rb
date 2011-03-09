# returns veid and status as a fact.
require 'facter'
if File.exist?('/usr/sbin/vzlist')
  Facter.add('VEIDs') do
    ENV["PATH"]="/bin:/sbin:/usr/bin:/usr/sbin"
    setcode do
      veid = []
      output = %x{vzlist -H -a -o veid,status}
      output.each{|line|
        veid.push(line.strip)
      }
      veid.join(';')
    end
  end
end
