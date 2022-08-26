FROM continuumio/miniconda3

ENV DEBIAN_FRONTEND noninteractive
  
RUN apt-get update && apt-get upgrade -y; \
    apt-get install -y \
        apt-utils sudo openssh-server htop screen vim ;  

COPY requirements.txt .
RUN conda install --yes --file requirements.txt --channel conda-forge

RUN mkdir /var/run/sshd

# Add all user into sudoers
RUN echo '%staff   ALL=(ALL:ALL) ALL' >> /etc/sudoers;
  
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
  
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
 
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
