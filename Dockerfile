FROM ubuntu:latest

# update
RUN apt-get -y update && apt-get install -y \
sudo \
wget \
vim

# install anaconda3
WORKDIR /opt
# download anaconda package and install anaconda
# archive -> https://repo.continuum.io/archive/
RUN wget https://repo.anaconda.com/archive/Anaconda3-2019.10-Linux-x86_64.sh && \
sh /opt/Anaconda3-2019.10-Linux-x86_64.sh -b -p /opt/anaconda3 && \
rm -f Anaconda3-2019.10-Linux-x86_64.sh
# set path
ENV PATH /opt/anaconda3/bin:$PATH

# update pip and conda
RUN pip install --upgrade pip

WORKDIR /
RUN mkdir /work

# install OpenCV
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
libsm6 \
libxext6 \
libxrender-dev \
libglib2.0-0 \
libgl1-mesa-dev
RUN pip install opencv-python

# downgrade matplotlib for heatmap of seaborn
RUN pip install matplotlib==3.1.0

# execute jupyterlab as a default command
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--LabApp.token=''"]