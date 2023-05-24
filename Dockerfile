# Use an appropriate base image with Python pre-installed
FROM python

# Set the working directory inside the container
WORKDIR /app

# Copy the entire project directory into the container
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin

# EXPOSE the port to the Host OS
EXPOSE 6379

# Specify the command to run when the container starts
CMD [ "python3", "main.py" ]


