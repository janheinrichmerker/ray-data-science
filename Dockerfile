FROM rayproject/ray:2.37.0-cpu AS cpu

# Install OpenJDK 11.
USER 0
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean
USER 1000

# Install Conda packages.
COPY environment.yml /tmp/
RUN /home/ray/anaconda3/bin/conda env update --name base --file /tmp/environment.yml --verbose

# Install Pip packages.
COPY requirements.txt /tmp/
RUN /home/ray/anaconda3/bin/pip install -r /tmp/requirements.txt


FROM rayproject/ray:2.37.0-gpu AS gpu

# Install OpenJDK 11.
USER 0
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk && \
    apt-get clean
USER 1000

# Install Conda packages.
COPY environment.yml /tmp/
RUN /home/ray/anaconda3/bin/conda env update --name base --file /tmp/environment.yml --verbose

# Install Pip packages.
COPY requirements.txt /tmp/
RUN /home/ray/anaconda3/bin/pip install -r /tmp/requirements.txt

FROM cpu
