FROM meriac/arm-gcc
MAINTAINER Milosch Meriac <milosch@meriac.com>

# Add missing dependencies for TFM
RUN apk add --no-cache cmake gcc g++ python3 python3-dev

# Install missing python modules
RUN pip3 install --no-cache-dir --upgrade pip && pip3 install --no-cache-dir pycrypto pyasn1

# by default create a prompt
CMD ["/bin/su","-l","build"]
