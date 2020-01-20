# Cron prom file does not exist
describe file('/etc/prometheus/node_exporter_textfiles/cron_root_basic.prom') do
  it { should_not exist }
end

# Creates the prom file
describe command('ls > /dev/null ; sudo promcron root_basic $?') do
  its('exit_status') { should eq 0 }
  its('stderr') { should eq '' }
  its('stdout') { should eq '' }
end

# Resulting prom file is as expected
describe file('/etc/prometheus/node_exporter_textfiles/cron_root_basic.prom') do
  it { should be_file }
  its('content') { should match /# HELP cron_root_basic_endtime Unix time in microseconds./ }
  its('content') { should match /# TYPE cron_root_basic_endtime gauge/ }
  its('content') { should match /cron_root_basic_endtime{user="root",promcron="endtime"}/ }
  its('content') { should match /# HELP cron_root_basic Process return code./ }
  its('content') { should match /# TYPE cron_root_basic gauge/ }
  its('content') { should match /cron_root_basic{user="root",promcron="value"} 0/ }
  its('size') { should > 200 }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end

# Run command again, this time in verbose mode
describe command('ls > /dev/null ; sudo promcron -v root_basic $?') do
  its('exit_status') { should eq 0 }
  its('stderr') { should eq '' }
  its('stdout') { should match /# HELP cron_root_basic_endtime Unix time in microseconds./ }
  its('stdout') { should match /# TYPE cron_root_basic_endtime gauge/ }
  its('stdout') { should match /cron_root_basic_endtime{user="root",promcron="endtime"}/ }
  its('stdout') { should match /# HELP cron_root_basic Process return code./ }
  its('stdout') { should match /# TYPE cron_root_basic gauge/ }
  its('stdout') { should match /cron_root_basic{user="root",promcron="value"} 0/ }
end

# Resulting prom file is as expected
describe file('/etc/prometheus/node_exporter_textfiles/cron_root_basic.prom') do
  it { should be_file }
  its('content') { should match /# HELP cron_root_basic_endtime Unix time in microseconds./ }
  its('content') { should match /# TYPE cron_root_basic_endtime gauge/ }
  its('content') { should match /cron_root_basic_endtime{user="root",promcron="endtime"}/ }
  its('content') { should match /# HELP cron_root_basic Process return code./ }
  its('content') { should match /# TYPE cron_root_basic gauge/ }
  its('content') { should match /cron_root_basic{user="root",promcron="value"} 0/ }
  its('size') { should > 200 }
  its('mode') { should cmp '0644' }
  its('owner') { should eq 'root' }
  its('group') { should eq 'root' }
end

# Remove prom file
describe command('sudo rm -f /etc/prometheus/node_exporter_textfiles/cron_root_basic.prom*') do
  its('exit_status') { should eq 0 }
end