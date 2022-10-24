USE students;
INSERT INTO `students` (`user_id`, `user_sort`, `server_ip`, `vpc_cidr`, `email`, `access_key`, `secret_key`, `user_password` , `externalid_token`, `server_test`, `server_check`, `region`, `region_az1`, `accountid`, `cloud9_url`) VALUES
('xs22-eu-west-1-user-0', 'user-0', '10.1.0.234', '10.1.0.0/24', 'xs22@fortinet.local', 'xxxx-xxx', 'xxxx-xxx','xxxxxxx', 'xxxx-xxx', '0', '00:00:00 AM', 'eu-west-1', 'eu-west-1a', '042xxxxxxxxx', 'https://accountid.region.cloud9.amazon.com');
COMMIT;