# FROM nginx:1.18
# RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get update -y && apt-get install -y git curl nodejs && curl -sL https://github.com/gohugoio/hugo/releases/download/v0.72.0/hugo_extended_0.72.0_Linux-64bit.tar.gz | tar -xz hugo && mv hugo /usr/bin && npm i -g postcss-cli autoprefixer postcss
# RUN git clone https://github.com/MicrosoftDocs/mslearn-aks-deployment-pipeline-github-actions /contoso-website
# WORKDIR /contoso-website/src
# RUN git submodule update --init themes/introduction
# RUN npm update
# RUN hugo && mv public/* /usr/share/nginx/html
# EXPOSE 80
# Use an official Nginx image as a base
FROM nginx:1.18

# Install dependencies, including a newer Node.js version and other required tools
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get update -y && \
    apt-get install -y git curl nodejs && \
    curl -sL https://github.com/gohugoio/hugo/releases/download/v0.72.0/hugo_extended_0.72.0_Linux-64bit.tar.gz | tar -xz hugo && \
    mv hugo /usr/bin && \
    npm install -g postcss-cli autoprefixer postcss

# Clone the repository
RUN git clone https://github.com/MicrosoftDocs/mslearn-aks-deployment-pipeline-github-actions /contoso-website

# Set the working directory
WORKDIR /contoso-website/src

# Initialize and update git submodules
RUN git submodule update --init themes/introduction

# Update npm packages
RUN npm update

# Build the Hugo site and move the generated files to the Nginx html directory
RUN hugo && mv public/* /usr/share/nginx/html

# Expose port 80
EXPOSE 80
