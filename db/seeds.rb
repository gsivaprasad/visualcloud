# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Users
user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'password', :password_confirmation => 'password'
user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please'
user.add_role :admin

#Regions
Region.create latitude: 38.597626, longitude: -80.454903, display_name: 'US East - N.Virginia', name: 'us-east-1'
Region.create latitude: 43.804133, longitude: -120.554201, display_name: 'US West - Oregon', name: 'us-west-2'
Region.create latitude: 36.778261, longitude: -119.417932, display_name: 'US West - N.California', name: 'us-west-1'
Region.create latitude: 53.41291, longitude: -8.24389, display_name: 'EU - Ireland', name: 'eu-west-1'
Region.create latitude: 1.352083, longitude: 103.819836, display_name: 'Asia Pacific - Singapore', name: 'ap-southeast-1'
Region.create latitude: 35.689488, longitude: 139.691706, display_name: 'Asia Pacific - Tokyo', name: 'ap-northeast-1'
Region.create latitude: -33.867487, longitude: 151.20699, display_name: 'Asia Pacific - Sydney', name: 'ap-southeast-2'
Region.create latitude: -23.548943, longitude: -46.638818, display_name: 'South America - Sao Paulo', name: 'sa-east-1'

#ResourceTypes
#AWS native resources
ResourceType.create(resource_class: 'ELB', name: 'ELB', parents_list: "" , small_icon: "components/elb.png", description: 'Elastic Load Balancer')
ResourceType.create(resource_class: 'EC2', name: 'EC2', parents_list: "ELB,Nginx" , small_icon: "amazon/AWS_Simple_Icons_Compute_Amazon_EC2.svg", description: 'Elastic Cloud Compute')
ResourceType.create(resource_class: 'RDS', name: 'RDS', parents_list: "Rails,Java,PHP" , small_icon: "components/rds.png", description: 'Relational Database Service')
ResourceType.create(resource_class: 'S3', name: 'S3', parents_list: "" , small_icon: "amazon/AWS_Simple_Icons_Storage_Amazon_S3.svg", description: 'S3 Bucket')
ResourceType.create(resource_class: 'ElastiCache', name: 'ElastiCache', parents_list: "" , small_icon: "amazon/AWS_Simple_Icons_Database_Amazon_ElastiCache.svg", description: 'ElastiCache')
#EC2 Type resources
ResourceType.create(resource_class: 'EC2', name: 'Rails', parents_list: "ELB,Nginx" , small_icon: "components/rails.png", description: 'Rails hosting instance running Unicorn as Application Server', roles: ['app', 'rails'].to_json)
ResourceType.create(resource_class: 'EC2', name: 'Mysql', parents_list: "Rails,Java,PHP" , small_icon: "components/mysql.png", description: 'MySQL database server', roles: ['db', 'mysql'].to_json)
ResourceType.create(resource_class: 'EC2', name: 'Nginx', parents_list: "ELB" , small_icon: "components/nginx.png", description: 'Nginx LoadBalancer for your application servers', roles: ['nginx'].to_json)
ResourceType.create(resource_class: 'EC2', name: 'Java', parents_list: "ELB,Nginx" , small_icon: "components/java.png", description: 'Java application server', roles: ['app', 'java'].to_json)
ResourceType.create(resource_class: 'EC2', name: 'PHP', parents_list: "ELB,Nginx" , small_icon: "components/php.png", description: 'PHP application server', roles: ['app', 'php'].to_json)

#Ami'S
ubuntu_amis = {
  'us-east-1' => 'ami-0145d268',
  'us-west-2' => 'ami-e0941ed0',
  'us-west-1' => 'ami-3ed8fb7b',
  'eu-west-1' => 'ami-20414854',
  'ap-southeast-1' => 'ami-7e2c612c',
  'ap-northeast-1' => 'ami-57b03456',
  'ap-southeast-2' => 'ami-6678ee5c',
  'sa-east-1' => 'ami-6b805b76'
}
Ami.create(image_id: ubuntu_amis.to_yaml, architecture:'amd64', name:'Precise Pangolin', description:'Ubuntu 12.04 LTS instance-store')

#Instance Types for ec2
ec2 = ResourceType.find_by_name('EC2')
ec2_instance_types = []
ec2_instance_types << InstanceType.create(api_name: 't1.micro',resource_type_id:ec2.id, name:'Micro', size:'613 MB',description: '613 MiB memory,Up to 2 EC2 Compute Units (for short periodic bursts),EBS storage only,32-bit or 64-bit platform,I/O Performance: Low,EBS-Optimized Available: No',label:'XS')
ec2_instance_types << InstanceType.create(api_name: 'm1.small',resource_type_id:ec2.id, name:'Small', size:'1.7 GB',description: '1.7 GiB memory,1 EC2 Compute Unit (1 virtual core with 1 EC2 Compute Unit),160 GB instance storage,32-bit or 64-bit platform,I/O Performance: Moderate,EBS-Optimized Available: No',label:'S')
ec2_instance_types << InstanceType.create(api_name: 'm1.medium',resource_type_id:ec2.id, name:'Medium', size:'3.75 GB',description: '3.75 GiB memory,2 EC2 Compute Unit (1 virtual core with 2 EC2 Compute Unit),410 GB instance storage,32-bit or 64-bit platform,I/O Performance: Moderate,EBS-Optimized Available: No',label:'M')
ec2_instance_types << InstanceType.create(api_name: 'm1.large',resource_type_id:ec2.id, name:'Large', size:'7.5 GB',description: '7.5 GiB memory,4 EC2 Compute Units (2 virtual cores with 2 EC2 Compute Units each),850 GB instance storage,64-bit platform,I/O Performance: High,EBS-Optimized Available: 500 Mbps',label:'L')
ec2_instance_types << InstanceType.create(api_name: 'm1.xlarge',resource_type_id:ec2.id, name:'Extra Large', size:'15 GB',description: '15 GiB memory,8 EC2 Compute Units (4 virtual cores with 2 EC2 Compute Units each),1,690 GB instance storage,64-bit platform,I/O Performance: High,EBS-Optimized Available: 1000 Mbps',label:'XL')
ec2_instance_types << InstanceType.create(api_name: 'm2.xlarge',resource_type_id:ec2.id, name:'High-Memory Extra Large', size:'17.1 GB',description: '17.1 GiB of memory,6.5 EC2 Compute Units (2 virtual cores with 3.25 EC2 Compute Units each),420 GB of instance storage,64-bit platform,I/O Performance: Moderate,EBS-Optimized Available: No',label:'XL+')
ec2_instance_types << InstanceType.create(api_name: 'm2.2xlarge',resource_type_id:ec2.id, name:'High-Memory Double Extra Large', size:'34.2 GB',description: '34.2 GiB of memory,13 EC2 Compute Units (4 virtual cores with 3.25 EC2 Compute Units each),850 GB of instance storage,64-bit platform,I/O Performance: High,EBS-Optimized Available: No',label:'2XL+')
ec2_instance_types << InstanceType.create(api_name: 'm2.4xlarge',resource_type_id:ec2.id, name:'High-Memory Quadruple Extra Large', size:'68.4 GB',description: '68.4 GiB of memory,26 EC2 Compute Units (8 virtual cores with 3.25 EC2 Compute Units each),1690 GB of instance storage,64-bit platform,I/O Performance: High,EBS-Optimized Available: 1000 Mbps',label:'4XL+')

#Instance Types for rds
rds = ResourceType.find_by_name('RDS')
InstanceType.create(api_name: 'db.t1.micro', name:'Micro', size:'',resource_type_id:rds.id,description: '630 MB memory, Up to 2 ECU (for short periodic bursts), 64-bit platform, Low I/O Capacity',label:'XS')
InstanceType.create(api_name: 'db.m1.small', name:'Small', size:'',resource_type_id:rds.id,description: '1.7 GB memory, 1 ECU (1 virtual core with 1 ECU), 64-bit platform, Moderate I/O Capacity',label:'S')
InstanceType.create(api_name: 'db.m1.large', name:'Large', size:'',resource_type_id:rds.id,description: '7.5 GB memory, 4 ECUs (2 virtual cores with 2 ECUs each), 64-bit platform, High I/O Capacity',label:'L')
InstanceType.create(api_name: 'db.m1.xlarge', name:'Extra Large', size:'',resource_type_id:rds.id,description: '15 GB of memory, 8 ECUs (4 virtual cores with 2 ECUs each), 64-bit platform, High I/O Capacity',label:'XL')
InstanceType.create(api_name: 'db.m2.xlarge', name:'High-Memory Extra Large', size:'',resource_type_id:rds.id,description: '17.1 GB memory, 6.5 ECU (2 virtual cores with 3.25 ECUs each), 64-bit platform, High I/O Capacity',label:'XL+')
InstanceType.create(api_name: 'db.m2.2xlarge', name:'High-Memory Double Extra Large', size:'',resource_type_id:rds.id,description: '34 GB of memory, 13 ECUs (4 virtual cores with 3,25 ECUs each), 64-bit platform, High I/O Capacity',label:'2XL+')
InstanceType.create(api_name: 'db.m2.4xlarge', name:'High-Memory Quadruple Extra Large', size:'',resource_type_id:rds.id,description: '68 GB of memory, 26 ECUs (8 virtual cores with 3.25 ECUs each), 64-bit platform, High I/O Capacity',label:'4XL+')

#Instance Types for ElastiCache
ec = ResourceType.find_by_name('ElastiCache')
InstanceType.create(api_name: 'cache.t1.micro', name:'Micro', size:'',resource_type_id:ec.id,description: '',label:'XS')
InstanceType.create(api_name: 'cache.m1.small', name:'Small', size:'',resource_type_id:ec.id,description: '',label:'S')
InstanceType.create(api_name: 'cache.m1.medium', name:'Medium', size:'',resource_type_id:ec.id,description: '',label:'M')
InstanceType.create(api_name: 'cache.m1.large', name:'Large', size:'',resource_type_id:ec.id,description: '',label:'L')
InstanceType.create(api_name: 'cache.m1.xlarge', name:'Extra Large', size:'',resource_type_id:ec.id,description: '',label:'XL')

#Create default data bags
system("knife data bag create nodes")
system("knife data bag create projects")
