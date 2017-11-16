#!/bin/bash

# This script downloads and installs the latest available Oracle Java 8 JDK CPU release or PSU release for compatible Macs

# Determine OS version

IdentifyLatestJDKRelease(){

# Determine the download URL for the latest CPU release or PSU release.

Java_8_JDK_CPU_URL=`/usr/bin/curl -s http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html | grep -ioE "http://download.oracle.com/otn-pub/java/jdk/.*?/jdk-8u.*?linux-x64.tar.gz" | head -1`

Java_8_JDK_PSU_URL=`/usr/bin/curl -s http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html | grep -ioE "http://download.oracle.com/otn-pub/java/jdk/.*?/jdk-8u.*?linux-x64.tar.gz" | tail -1`

# Use the Version variable to determine if the script should install the latest CPU release or PSU release.

 if [[ "$Version" = "PSU" ]] && [[ "$Java_8_JDK_PSU_URL" != "" ]]; then
    fileURL="$Java_8_JDK_PSU_URL"
    /bin/echo "Installing Oracle Java 8 JDK Patch Set Update (PSU) -" "$Java_8_JDK_PSU_URL"
 elif [[ "$Version" = "PSU" ]] && [[ "$Java_8_JDK_PSU_URL" = "" ]]; then
     /bin/echo "Unable to identify download URL for requested Oracle Java 8 JDK Patch Set Update (PSU). Exiting."
     exit 0
 fi
 
 if [[ "$Version" = "CPU" ]] && [[ "$Java_8_JDK_CPU_URL" != "" ]]; then
    fileURL="$Java_8_JDK_CPU_URL"
    /bin/echo "Installing Oracle Java 8 JDK Critical Patch Update (CPU) -" "$Java_8_JDK_PSU_URL"
 elif [[ "$Version" = "CPU" ]] && [[ "$Java_8_JDK_CPU_URL" = "" ]]; then
    /bin/echo "Unable to identify download URL for requested Oracle Java 8 JDK Critical Patch Update (CPU). Exiting."
    exit 0
 fi

}


    # Specify name of downloaded disk image

    java_eight_jdk_tgz="/tmp/java_eight_jdk.tar.gz"
 

    
    # Use the Version variable to set if you want to download the latest CPU release or the latest PSU release.
    # The difference between CPU and PSU releases is as follows:
    #
    # Critical Patch Update (CPU): contains both fixes to security vulnerabilities and critical bug fixes.
    #
    # Patch Set Update (PSU): contains all the fixes in the corresponding CPU, plus additional fixes to non-critical problems. 
    #
    # For more details on the differences between CPU and PSU updates, please see the link below:
    #
    # http://www.oracle.com/technetwork/java/javase/cpu-psu-explained-2331472.html
    #
    # Setting the variable as shown below will set the script to install the CPU release:
    #
    # Version=CPU
    #
    # Setting the variable as shown below will set the script to install the PSU release:
    #
    # Version=PSU
    #
    # By default, the script is set to install the CPU release.
    
    Version=CPU
    
    # Identify the URL of the latest Oracle Java 8 JDK software disk image
    # using the IdentifyLatestJDKRelease function.
    
    IdentifyLatestJDKRelease
    
    # Download the latest Oracle Java 8 JDK software disk image
    # The curl -L option is needed because there is a redirect 
    # that the requested page has moved to a different location.

    /usr/bin/curl --retry 3 -Lo "$java_eight_jdk_tgz" "$fileURL" -H "Cookie: oraclelicense=accept-securebackup-cookie"

 
exit 0
