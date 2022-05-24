s3_bucket="upgrad-darshan"
name="Darshan"
apt update -y
apt install awscli -y

if [ apache2 != $(dpkg -l | grep apache2 | awk 'NR==1 {print $2}') ]
then
apt install apache2 -y
fi

if [ $(systemctl status apache2 | grep active | awk '{print $2}') = inactive ]
then
systemctl start apache2
fi

if [ enabled = $(systemctl is-enabled apache2 | awk '{print $1}' ) ]
then
systemctl enable apache2
fi

timestamp=$(date '+%d%m%Y-%H%M%S')

tar -cf /tmp/${name}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log

aws s3 cp /tmp/${name}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${name}-httpd-logs-${timestamp}.tar





