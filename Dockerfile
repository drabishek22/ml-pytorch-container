# Use a strict CUDA development base image
FROM perfectweb/base:cuda-10.2-devel-ubuntu18.04

# Add missing GPG key for NVIDIA repository and universe repository
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub && \
    apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository universe && \
    apt-get update

# Install essential system dependencies
RUN apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    sudo \
    python3 \
    python3-pip \
    libopenblas-dev \
    libopencv-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip to the latest version
RUN pip3 install --no-cache-dir --upgrade pip

# Install PyTorch and torchvision from the PyTorch repository
RUN pip3 install --no-cache-dir \
    torch==1.8.1+cu102 \
    torchvision==0.9.1+cu102 \
    -f https://download.pytorch.org/whl/torch_stable.html

# Copy requirements.txt into the container
COPY requirements.txt /app/requirements.txt

# Set the working directory
WORKDIR /app

# Install remaining Python dependencies from requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose the JupyterLab port
EXPOSE 8888

# Set default command
CMD ["bash"]


