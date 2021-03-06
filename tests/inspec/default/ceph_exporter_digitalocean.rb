# encoding: utf-8
# author: Mesaguy

if os.name == 'arch'
    describe file('/opt/prometheus/exporters/ceph_exporter_digitalocean/active') do
        it { should be_symlink }
        its('mode') { should cmp '0755' }
        its('owner') { should eq 'root' }
        its('group') { should eq 'prometheus' }
    end
    
    describe file('/opt/prometheus/exporters/ceph_exporter_digitalocean/active/ceph_exporter') do
        it { should be_file }
        it { should be_executable }
        its('mode') { should cmp '0755' }
        its('owner') { should eq 'root' }
        its('group') { should eq 'prometheus' }
    end
end
