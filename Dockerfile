#Use Python 3.11 as a base image
FROM python:3.11
# Copy contents into image
  COPY . .
# install pip dependencies from requirements file
 RUN pip install -r requirements.txt
# Expose correct port

ENV PORT=8080

# Create an entrypoint
ENTRYPOINT python lbg.py --PORT ${PORT}