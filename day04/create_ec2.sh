#!/bin/bash
set -euo pipefail
# above command shows errors more beautifully

<< task
Create the aws ec2 with the shell-scripting 
task

check_awscli() {
	if ! command -v aws &> /dev/null; then
		echo "Please install the aws cli first"
		return 1
	fi
}

install_awscli() {
	echo "Installing te aws cli"
	curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	sudo apt-get install -y unzip &> /dev/null
	unzip -q awscliv2.zip
	sudo ./aws/install

	aws --version

	rm -rf awscliv2.zip ./aws
}

wait_for_instance() {
	local instance_id="$1"
	echo "Waiting for the $instance_id to be in the running state"

	while true; do
		state=$(aws ec2 describe-instances --instance-ids "$instance_id" --query 'Reservations[0].Instances[0].State.Name' --output text )
		if [[ "$state" == "running" ]]; then
			echo "Instance $instance_id is now running."
			break
		fi
		sleep 10
	done
}

create_ec2_instance() {
	local ami_id="$1"
	local instance_type="$2"
	local key_name="$3"
	local subnet_id="$4"
	local security_group_ids="$5"
	local instance_name="$6"

	#Run AWS CLI Command to create the ec2 instance
	instance_id=$(aws ec2 run-instances \
		--image-id "$ami_id" \
		--instance-type "$instance_type" \
		--key-name "$key_name" \
		--subnet-id "$subnet_id" \
		--security-group-ids "$security_group_ids" \
		--tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance_name}]" \
		--query 'Instances[0].InstanceId' \
		--output text
	)

	if [[ -z "$instance_id" ]]; then
		echo "Failed to create ec2 instance." >&2
		exit 1
	fi

	echo "Instance $instance_id created Successfully."

	#Wait till the instance is up and running
	wait_for_instance "$instance_id"
}

main() {
	if ! check_awscli; then
		install_awscli || exit 1
	fi

	echo "Creating the EC2 Instance"

	#Specifying the parameters to create the ec2 instance
	
	AMI_ID="ami-00bb6a80f01f03502"
	INSTANCE_TYPE="t2.micro"
	KEY_NAME="shell-scipting-for-devops-keys"
	SUBNET_ID="subnet-080145bce248708d0"
	SECURITY_GROUP_IDS="sg-03cc020251f7b73f6"  # Add your Security group IDS seperated by space
	INSTANCE_NAME="Shell-Script-EC2-Demo"

	#Call the function to create the EC2 instance
	create_ec2_instance "$AMI_ID" "$INSTANCE_TYPE" "$KEY_NAME" "$SUBNET_ID" "$SECURITY_GROUP_IDS" "$INSTANCE_NAME"
}

main "$@"
