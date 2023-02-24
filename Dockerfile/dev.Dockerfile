FROM python:3.11.2

WORKDIR /root
COPY Dockerfile/gurobi.sh gurobi.sh
COPY Dockerfile/secrets/gurobi.lic gurobi.lic
RUN chsh -s /bin/bash && \
    useradd -u 1000 -m ubuntu && \
    apt update && \
    apt install -y --no-install-recommends \
        git \
        wget && \
    rm -rf /var/lib/apt/lists/* && \
    bash gurobi.sh && \
    rm gurobi.sh

WORKDIR /home/ubuntu
USER ubuntu
COPY Dockerfile/dev_requirements.txt dev_requirements.txt
RUN python -m pip install --no-cache-dir pip==23.0.1 && \
    python -m pip install --no-cache-dir setuptools==67.3.2 && \
    python -m pip install --no-cache-dir wheel==0.38.4 && \
    python -m pip install --no-cache-dir -r dev_requirements.txt

CMD [ "/bin/bash" ]
