require 'facter'
Facter.add(:ius_installed) do
  confine :osfamily => %w{RedHat}
  setcode do
    rpm = %x{rpm -qa | grep ius-release}.chomp
    if rpm !~ /ius-release/
      output = false
    else
      output = true
    end
    output
  end
end
