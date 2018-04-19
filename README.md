# Zoneminder

Docker container for [zoneminder v1.31.1][3]

## Forked/Inspiration from

  - [Quantum Object][5]
  - [dlandon][9]

"ZoneMinder the top Linux video camera security and surveillance solution. ZoneMinder is intended for use in single or multi-camera video security applications, including commercial or home CCTV, theft prevention and child, family member or home monitoring and other domestic care scenarios such as nanny cam installations. It supports capture, analysis, recording, and monitoring of video data coming from one or more video or network cameras attached to a Linux system. ZoneMinder also support web and semi-automatic control of Pan/Tilt/Zoom cameras using a variety of protocols. It is suitable for use as a DIY home video security system and for commercial or professional video security and surveillance. It can also be integrated into a home automation system via X.10 or other protocols. If you're looking for a low cost CCTV system or a more flexible alternative to cheap DVR systems then why not give ZoneMinder a try?"

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 16.04 use the commands:

    $ sudo apt-get update
    $ sudo wget -qO- https://get.docker.com/ | sh

## Usage

To run container use the command below:

    $ docker-compose up

## Set Environment Variables
  
in docker-compose.yml:  
  
| Variable Name | Description | Default |
|----------------------|----------------------|------------------|
| MY_SQL_ROOT_PASSWORD | Sets mySQL root password | vmPassword |
| TZ | sets TimeZone in PHP | America/New_York |
| EMAIL_ADDRESS | used for [ssmtp][7] configuration | |
| EMAIL_PASSWORD | used for [ssmtp][7] configuration | |
| SMTP_SERVER | used for [ssmtp][7] configuration | smtp.gmail.com:587 |
| ROOT_SMTP_SERVER | used for [ssmtp][7] configuration | gmail.com |

__Note:__ Make sure to scrub this file of you email credentials before posting to the world wide web

## Email Configuration

This image installs [ssmtp][8] and tries to configure Zoneminder using this [guide][7]

## Accessing the Zoneminder applications:

After that check with your browser at addresses plus the port assigned by docker:

  - **http://host_ip:port/zm/**

Then log in with login/password : admin/admin , Please change password right away and check on-line [documentation][6] to configure zoneminder.

To access the container from the server that the container is running :

    $ docker exec -it container_id bash -l

## TODO's

 - Add volumes for mySQL and Zoneminder events/images
 - Add SSL cert for Apache
 - Add ZM Event Server for notifications (used by zmninja)

## More Info

About [zoneminder][1]

[1]:http://www.zoneminder.com/
[2]:https://www.docker.com
[3]:http://www.zoneminder.com/downloads
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-zoneminder
[6]:http://www.zoneminder.com/wiki/index.php/Documentation
[7]:https://wiki.zoneminder.com/How_to_get_ssmtp_working_with_Zoneminder
[8]:https://help.ubuntu.com/community/EmailAlerts
[9]:https://github.com/dlandon/zoneminder
