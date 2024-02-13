#/bin/bash

# Validated that user should be root user 

if [[ "${UID}" -ne 0 ]]
then 
        echo "Please run with sudo or root "
	exit 1 
fi

#User should provide atleast one argument 

if [[ "${#}" -lt 1 ]]
then 
	echo "Usage :${0} Username [Comment]..  "
	echo 'Please add the User_name and comments '
	exit 1
fi

# Store Ist argument as Username 

USER_NAME="${1}"

#In case of more than one argument 
shift 
Comment="${@}"

#Create a password 
PASSWORD=$(date +%s$RANDOM)

#Create  a USERNAME
useradd -m $USER_NAME

#Check user is created successfully 
if [[ $? -ne 0 ]]
then 
	echo "User not created successfully "
	exit 1
fi

#Set the Password 
echo "$USER_NAME:$PASSWORD" | chpasswd 

if [[ $? -ne 0 ]]
then
        echo "Password not updated  successfully"
        exit 1
fi

#Change the Password at first login 

passwd -e $USER_NAME

# Display the USERNAME/Password 

echo
echo "USERNAME is $USER_NAME"
echo
echo "Intial Password is $PASSWORD"


