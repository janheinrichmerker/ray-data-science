FROM rayproject/ray:2.37.0-cpu

# Install Conda packages.
COPY environment.yml /tmp/
RUN /home/ray/anaconda3/bin/conda env update --name base --file /tmp/environment.yml

# Install Pip packages.
COPY requirements.txt /tmp/
RUN /home/ray/anaconda3/bin/pip install -r /tmp/requirements.txt && sleep 3
