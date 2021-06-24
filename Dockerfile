FROM ubuntu:16.04
ARG version=210615184
# --build-arg version=210615184

ENV DEBIAN_FRONTEND noninteractive
ENV acunetix_install = acunetix_14.3.${version}_x64.sh


# acunetix
RUN  apt-get update --fix-missing
ADD acunetix_14.3.${version}_x64.sh /tmp/acunetix_14.3.${version}_x64.sh
ADD wvsc /tmp/wvsc
ADD license_info.json /tmp/license_info.json
ADD wa_data.dat  /tmp/wa_data.dat 
ADD install.expect /tmp/install.expect
WORKDIR /tmp
RUN apt-get -y install libgbm1 libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 sudo bzip2 wget expect libxdamage1 libgtk-3-0 libasound2 libnss3 libxss1 libx11-xcb1;\
    chmod 444 license_info.json wa_data.dat;\
    chmod +x /tmp/acunetix_14.3.${version}_x64.sh;\
    chmod +x /tmp/install.expect && expect /tmp/install.expect;\
    cp /tmp/wvsc /home/acunetix/.acunetix/v_${version}/scanner/;\
    cp /tmp/wa_data.dat /home/acunetix/.acunetix/data/license/;\
    cp /tmp/license_info.json /home/acunetix/.acunetix/data/license/
CMD su -l acunetix -c /home/acunetix/.acunetix/start.sh
EXPOSE 3443
